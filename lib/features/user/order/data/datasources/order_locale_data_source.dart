import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/network/success_response.dart';
import '../../../product/data/models/attributes_model.dart';
import '../../../product/data/models/product_model.dart';
import '../models/cart_model.dart';
import 'order_remote_data_source.dart';

abstract class OrderLocaleDataSource {
  Future<bool> addProductToCart({required List<CartItem> cartProductList});

  Future<bool> deleteProductToCart({
    required List<CartItem> cartProductList,
    required String id,
  });

  Future<List<CartItem>> getCartList({required bool isRemote});

  List<CartItem> setQuantity(
      {required List<CartItem> cartProductList,
      required String productId,
      required bool isIncrease});

  Future<ApiSuccessResponse> clearCartUseCase();
}

@LazySingleton(as: OrderLocaleDataSource)
class OrderLocaleDataSourceImpl implements OrderLocaleDataSource {
  final SharedPreferences sharedPreferences;
  final OrderRemoteDataSource remoteDataSource;
  OrderLocaleDataSourceImpl({required this.sharedPreferences,required this.remoteDataSource});

  @override
  Future<ApiSuccessResponse> clearCartUseCase() async {
    if (sharedPreferences.containsKey("cartList")) {
      await sharedPreferences.remove("cartList");
    }
    return ApiSuccessResponse(data: true);
  }

  @override
  Future<bool> addProductToCart(
      {required List<CartItem> cartProductList}) async {
    List<String> carts = [];
    for (var cartModel in cartProductList) {
      final json = jsonEncode(cartModel.toJsonForLocaleDataBase());
      carts.add(json);
    }
    sharedPreferences.setStringList("cartList", carts);
    return true;
  }

  @override
  Future<List<CartItem>> getCartList({required bool isRemote}) async {
    List<String>? carts = [];
    if (sharedPreferences.containsKey("cartList")) {
      carts = sharedPreferences.getStringList("cartList");
    }
    List<CartItem> cartList = [];
    List<int> productIds = [];
    for (var cart in carts!) {
      final data = CartItem.fromJson(jsonDecode(cart));
      cartList.add(data);
      productIds.add(data.productId!.toInt());
    }
    if (productIds.isNotEmpty&& isRemote) {
      final response = await remoteDataSource.checkProductAvilabilaty(productIds: productIds);
      final result = await checkAndUpdateProductAvailability(cartProductList: cartList, availableProducts: response.data);
      return result;

    }else{
      return cartList;
    }
  }


  @override
  Future<bool> deleteProductToCart({
    required List<CartItem> cartProductList,
    required String id,
  })
  async {
    cartProductList.removeWhere((cartItem) => cartItem.uniqueProductId == id);
    List<String> carts = [];
    for (var cartModel in cartProductList) {
      carts.add(jsonEncode(cartModel));
    }
    sharedPreferences.setStringList("cartList", carts);
    return true;
  }

  @override
  List<CartItem> setQuantity(
      {required List<CartItem> cartProductList,
      required String productId,
      required bool isIncrease}) {
    final cartItemIndex = cartProductList
        .indexWhere((cartItem) => cartItem.uniqueProductId == productId);
    if (cartItemIndex != -1) {
      CartItem? cartItem = cartProductList[cartItemIndex];
      num qty = isIncrease ? (cartItem.qty! + 1) : (cartItem.qty! - 1);
      num price = qty * (cartItem.currentItemPrice ?? 1);
      cartItem = cartItem.copyWith(qty: qty, currentItemPrice: price);
      if (cartItem.qty == 0) {
        cartProductList
            .removeWhere((element) => element.uniqueProductId == productId);
      } else {
        cartProductList
            .removeWhere((element) => element.uniqueProductId == productId);
        cartProductList.insert(cartItemIndex, cartItem);
      }
      List<String> carts = [];
      for (var cartModel in cartProductList) {
        carts.add(jsonEncode(cartModel.toJsonForLocaleDataBase()));
      }
      sharedPreferences.setStringList("cartList", carts);
    }

    return cartProductList;
  }



  Future<List<CartItem>> checkAndUpdateProductAvailability({
    required List<CartItem> cartProductList,
    required List<ProductModel> availableProducts,
  }) async {
    List<CartItem> updatedCartList = [];

    for (var cartItem in cartProductList) {
      // البحث عن المنتج في القائمة المتاحة
      ProductModel? availableProduct = availableProducts.firstWhere(
        (product) => product.id == cartItem.productId,
        orElse: () => ProductModel(), // Return empty product if not found
      );

      // لو المنتج مش موجود أصلاً، خليه في الكارت بس بـ stock = 0
      if (availableProduct.id == null) {
        CartItem outOfStockItem = cartItem.copyWith(stock: 0);
        updatedCartList.add(outOfStockItem);
        continue;
      }

      // التحقق من isAvailable (لازم يكون 1)
      if (availableProduct.isAvailable != 1) {
        CartItem outOfStockItem = cartItem.copyWith(
          stock: 0,
          productModel: availableProduct,
        );
        updatedCartList.add(outOfStockItem);
        continue;
      }

      // التحقق من الـ attributes
      bool attributesValid = true;
      List<ProductAttributes> validatedAttributes = [];

      if (cartItem.productAttributes != null &&
          cartItem.productAttributes!.isNotEmpty) {
        for (var cartAttribute in cartItem.productAttributes!) {
          var availableAttribute = availableProduct.attributes?.firstWhere(
            (attr) => attr.attributeId == cartAttribute.attribute,
            orElse: () => AttributesModel(),
          );

          // لو الـ attribute مش موجود، المنتج مش صالح
          if (availableAttribute?.attributeId == null) {
            attributesValid = false;
            break;
          }

          // التحقق من الـ attribute values
          List<num> validAttributeValues = [];
          if (cartAttribute.attributeValues != null) {
            for (var valueId in cartAttribute.attributeValues!) {
              var availableValue = availableAttribute?.values?.firstWhere(
                (val) => val.attributeValueId == valueId,
                orElse: () => Values(),
              );

              // لو القيمة موجودة، أضفها
              if (availableValue?.attributeValueId != null) {
                validAttributeValues.add(valueId);
              }
            }
          }

          // لو مفيش قيم صحيحة، الـ attribute مش صالح
          if (validAttributeValues.isEmpty) {
            attributesValid = false;
            break;
          }

          validatedAttributes.add(ProductAttributes(
            attribute: cartAttribute.attribute,
            attributeValues: validAttributeValues,
          ));
        }
      }

      // لو الـ attributes مش صالحة، خلي الـ stock = 0
      if (!attributesValid) {
        CartItem outOfStockItem = cartItem.copyWith(
          stock: 0,
          productModel: availableProduct,
        );
        updatedCartList.add(outOfStockItem);
        continue;
      }

      // حساب السعر الإجمالي للـ attributes
      num totalAttributePrice = 0;
      num? attributeStock;
      
      if (validatedAttributes.isNotEmpty) {
        for (var attr in validatedAttributes) {
          var availableAttribute = availableProduct.attributes?.firstWhere(
            (a) => a.attributeId == attr.attribute,
          );
          if (availableAttribute != null && attr.attributeValues != null) {
            for (var valueId in attr.attributeValues!) {
              var value = availableAttribute.values?.firstWhere(
                (v) => v.attributeValueId == valueId,
                orElse: () => Values(),
              );
              totalAttributePrice += value?.price ?? 0;
              
              // استخدم أقل qty من الـ attribute values
              if (value?.qty != null) {
                final valueQty = value!.qty!;
                if (attributeStock == null || valueQty < attributeStock) {
                  attributeStock = valueQty;
                }
              }
            }
          }
        }
      }

      // حساب الـ stock النهائي (من الـ attributes أو من المنتج نفسه)
      num finalStock = attributeStock ?? availableProduct.qty ?? 0;

      // حساب السعر النهائي
      num finalPrice = (availableProduct.price ?? 0) + totalAttributePrice;
      num currentItemTotalPrice = finalPrice * (cartItem.qty ?? 1);

      // تحديث الـ cart item
      CartItem updatedCartItem = cartItem.copyWith(
        productModel: availableProduct,
        price: finalPrice,
        currentItemPrice: currentItemTotalPrice,
        qty: cartItem.qty,
        stock: finalStock,
        productId: availableProduct.id,
        productAttributes: validatedAttributes.isNotEmpty ? validatedAttributes : null,
      );

      updatedCartList.add(updatedCartItem);
    }

    List<String> carts = [];
    for (var cartModel in updatedCartList) {
      final json = jsonEncode(cartModel.toJsonForLocaleDataBase());
      carts.add(json);
    }
    sharedPreferences.setStringList("cartList", carts);

    return updatedCartList;
  }


}
