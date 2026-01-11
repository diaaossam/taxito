import 'dart:async';
import 'dart:convert';
import 'package:aslol/features/order/data/models/coupon_model.dart';
import 'package:aslol/features/order/data/models/promo_code_params.dart';
import 'package:aslol/features/order/domain/usecases/apply_promo_code_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/cart_model.dart';
import '../../../domain/usecases/add_product_to_cart_use_case.dart';
import '../../../domain/usecases/delete_product_from_cart_list.dart';
import '../../../domain/usecases/get_cart_list_use_case.dart';
import '../../../domain/usecases/order_place_use_case.dart';
import '../../../domain/usecases/set_quantity_use_case.dart';

part 'cart_state.dart';

@Injectable()
class CartCubit extends Cubit<CartState> {
  final AddProductToCartUseCase addProductToCartUseCase;
  final GetCartListUse getCartListUse;
  final DeleteProductToCartUseCase deleteProductToCartUseCase;
  final SetQuantityUseCase setQuantityUseCase;
  final OrderPlaceUseCase orderPlaceUseCase;
  final ApplyPromoCodeUseCase applyPromoCodeUseCase;
  final SharedPreferences sharedPreferences;

  TextEditingController discount = TextEditingController();

  CartCubit(
    this.addProductToCartUseCase,
    this.getCartListUse,
    this.deleteProductToCartUseCase,
    this.setQuantityUseCase,
    this.orderPlaceUseCase,
    this.applyPromoCodeUseCase,
    this.sharedPreferences,
  ) : super(CartInitial());

  List<CartItem> _cartList = [];
  double amount = 0.0;
  num totalCount = 0;
  double couponDiscount = 0.0;
  double pointDiscount = 0.0;
  String? couponCode;

  void getCartData({required bool isRemote}) async {
    emit(GetCartListLoading());
    _cartList = [];
    amount = 0.0;
    totalCount = 0;
    final response = await getCartListUse(isRemote: isRemote);
    response.fold((l) {
      _cartList = [];
    }, (r) async {
      for (var element in r) {
        amount = amount + ((element.price ?? 0) * (element.qty ?? 1));
        totalCount = totalCount + (element.qty ?? 1);
      }
      _cartList = r;
      initCoupon();
      emit(GetCartListState());
    });
  }

  void initCoupon() async {
    final jsonString = sharedPreferences.getString("coupon");
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final CouponModel couponModel = CouponModel.fromJson(jsonMap);
      couponCode = couponModel.type;
      if (couponModel.isValid == true) {
        if (couponModel.type == "percentage") {
          final dic = (couponModel.discountAmount ?? 1) / 100;
          double discountValue = amount * dic;
          couponDiscount = discountValue;
        } else {
          couponDiscount = couponModel.discountAmount!.toDouble();
        }
      }
      discount.text = couponCode ?? "";
      emit(InitCachedCouponCode(code: couponCode ?? ""));
    }
  }

  List<CartItem> get cartList => _cartList;

  void addToCart(
    CartItem cartModel,
  ) async {

    amount = 0.0;
    totalCount = 0;
    couponDiscount = 0;
    couponCode = null;
    emit(AddCartListStateLoading());
    final index = _cartList.indexWhere(
        (item) => item.uniqueProductId == cartModel.uniqueProductId);

    if (index != -1) {
      _cartList[index].qty;
      _cartList[index].qty = _cartList[index].qty! + 1;
      _cartList[index].price =
          _cartList[index].price! + _cartList[index].currentItemPrice!;
    } else {
      _cartList.add(cartModel);
    }
    await addProductToCartUseCase(cartProductList: _cartList);

    getCartData(isRemote: false);
    Future.delayed(
      const Duration(milliseconds: 500),
      () => emit(AddCartListStateSuccess()),
    );
  }

  void clearCartAndAddNewItem(CartItem cartModel) async {
    _cartList.clear();
    amount = 0.0;
    totalCount = 0;
    couponDiscount = 0;
    couponCode = null;

    // Delete coupon if exists
    if (sharedPreferences.containsKey("coupon")) {
      sharedPreferences.remove("coupon");
    }

    // Now add the new item
    emit(AddCartListStateLoading());
    _cartList.add(cartModel);
    await addProductToCartUseCase(cartProductList: _cartList);

    getCartData(isRemote: false);
    Future.delayed(
      const Duration(milliseconds: 500),
      () => emit(AddCartListStateSuccess()),
    );
  }

  Future<void> appleCouponToCart({required String code}) async {
    emit(ApplyCouponToCartLoading());
    final response = await applyPromoCodeUseCase(
        params: PromoCodeParams(coupon: code, totalPrice: amount.toString()));
    emit(response.fold((l) => ApplyCouponToCartFailure(error: l.msg), (r) {
      CouponModel couponModel = r.data;
      couponCode = code;
      if (couponModel.isValid == true) {
        couponModel = couponModel.copyWith(
          coupon: code,
        );
        String jsonCoupon = json.encode(couponModel.toJson());
        sharedPreferences.setString("coupon", jsonCoupon);
        if (couponModel.type == "percentage") {
          final dic = (couponModel.discountAmount ?? 1) / 100;
          double discountValue = amount * dic;
          couponDiscount = discountValue;
        } else {
          couponDiscount = couponModel.discountAmount!.toDouble();
        }
      }
      return ApplyCouponToCartSuccess(couponModel: r.data);
    }));
  }

  void deleteCoupon() {
    couponDiscount = 0;
    couponCode = null;
    emit(DeleteCouponToCartSuccess());
  }

  void deleteItemFromCart({required String id}) async {
    couponDiscount = 0.0;
    couponCode = null;

    emit(DeleteItemFromCartLoading());
    final response = await deleteProductToCartUseCase(
      cartProductList: _cartList,
      id: id,
    );
    getCartData(isRemote: false);
    emit(response.fold((l) => DeleteItemFromCartFailure(),
        (r) => DeleteItemFromCartSuccess()));
  }

  void setQuantity(
      {required String productId, required bool isIncrease}) async {
    amount = 0.0;
    totalCount = 0;
    couponDiscount = 0.0;
    couponCode = null;
    final response = setQuantityUseCase(
        productId: productId,
        cartProductList: _cartList,
        isIncrease: isIncrease);

    _cartList = response;
    for (var element in response) {
      amount = amount + ((element.price ?? 1) * (element.qty ?? 1));
      totalCount = totalCount + (element.qty ?? 1);
    }
    emit(SetQuantityStateSuccess());
  }

  Future<Map<String, dynamic>> checkIfProductInCart(
      {required String productId}) async {
    bool isInCart = false;
    CartItem? cartModel;
    final response = await getCartListUse(isRemote: false);
    response.fold((l) {}, (r) {
      var contain = _cartList.where((element) {
        return element.uniqueProductId == productId;
      }).toList();
      if (contain.isEmpty) {
        isInCart = false;
      } else {
        cartModel = contain.first;
        isInCart = true;
      }
    });

    return {
      "cart": cartModel,
      "inCart": isInCart,
    };
  }

  Future<void> placeOrder({required CartModel cart}) async {
    emit(PlaceOrderLoading());
    final response = await orderPlaceUseCase(placeOrderModel: cart);
    emit(response.fold(
      (l) => PlaceOrderFailure(msg: l.msg),
      (r) {
        if (sharedPreferences.containsKey("coupon")) {
          sharedPreferences.remove("coupon");
        }
        return PlaceOrderSuccess(orderId: r.data);
      },
    ));
  }
}
