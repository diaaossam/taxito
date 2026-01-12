import 'package:taxito/features/user/order/data/models/cart_model.dart';
import 'package:taxito/features/user/product/data/models/attributes_model.dart';
import 'package:taxito/features/user/product/data/models/product_model.dart';
import 'package:taxito/features/user/product/domain/usecases/get_product_details_use_case.dart';
import 'package:taxito/features/user/product/domain/usecases/toggle_wishlist_use_case.dart';
import 'package:taxito/features/user/product/product_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

@Injectable()
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final ToggleWishlistUseCase toggleWishlistUseCase;

  CartItem cartItem = CartItem();

  Map<num, List<num>> selectedValues = {};

  ProductDetailsCubit(this.getProductDetailsUseCase, this.toggleWishlistUseCase)
      : super(ProductDetailsInitial());

  Future<void> getProductDetailsById(
      {required num productId,
      required num supplierId,
      ProductModel? model}) async {
    emit(GetProductDetailsLoading());
    final response =
        await getProductDetailsUseCase(id: productId, supplierId: supplierId);
    emit(response.fold((l) => GetProductDetailsFailure(msg: l.msg), (r) {
      ProductModel productModel =
          (r.data as ProductModel).copyWith(supplier: model?.supplier);
      _initCartData(productModel: productModel);
      return GetProductDetailsSuccess(
        cartItem: cartItem,
        productModel: r.data,
      );
    }));
  }

  Future<void> toggleWishlist({required num id, required String type}) async {
    emit(ToggleWishlistLoading());
    final response = await toggleWishlistUseCase(id: id, type: type);
    emit(response.fold((l) => ToggleWishlistFailure(msg: l.msg),
        (r) => ToggleWishlistSuccess()));
  }

  void updateCartItem({required CartItem item}) {
    cartItem = item;
    emit(GetProductDetailsSuccess(
      productModel: cartItem.productModel!,
      cartItem: cartItem,
    ));
  }

  void _initCartData({required ProductModel productModel}) {
    num total = 0;
    List<Values> listOfValues = [];
    if (productModel.attributes != null &&
        productModel.attributes!.isNotEmpty) {
      Map<String, dynamic> map =
          initAttributes(productModel.attributes ?? [], productModel);
      total = map['totalAdditionPrice'];
    }

    cartItem = cartItem.copyWith(
        productModel: productModel,
        price: total + productModel.price!,
        qty: 1,
        uniqueProductId: ProductHelper().formatUniqueId(
            productId: productModel.id ?? 0, listOfValues: listOfValues),
        productId: productModel.id,
        currentItemPrice: total + productModel.price!);

    emit(UpdateCartItemState(cartItem: cartItem));
  }

  Map<String, dynamic> initAttributes(
      List<AttributesModel> attributes, ProductModel model) {
    double totalAdditionPrice = 0;
    List<Values> list = [];

    selectedValues.clear();
    for (final attribute in attributes) {
      final isRequired = attribute.isRequired == 1;
      final hasValues = attribute.values?.isNotEmpty == true;
      if (isRequired && hasValues) {
        final firstValueId = attribute.values!.first.attributeValueId;
        if (firstValueId != null) {
          selectedValues[attribute.attributeId!] = [firstValueId];
          list.add(attribute.values!.first);
          totalAdditionPrice += attribute.values?.first.price ?? 0;
        }
      }
    }
    emit(GetProductDetailsSuccess(
      productModel: model,
      cartItem: cartItem,
    ));
    return {"totalAdditionPrice": totalAdditionPrice, "values": list};
  }

  void toggleAttributeValue({
    required num attributeId,
    required num valueId,
    required bool isMultiple,
  }) {
    final currentSelections = Map<num, List<num>>.from(selectedValues);
    final selectedList = List<num>.from(currentSelections[attributeId] ?? []);
    final attributes = cartItem.productModel?.attributes ?? [];
    final attribute = attributes.firstWhere(
      (attr) => attr.attributeId == attributeId,
      orElse: () => AttributesModel(),
    );
    final value = attribute.values?.firstWhere(
      (v) => v.attributeValueId == valueId,
      orElse: () => throw Exception("Value not found"),
    );

    if (value == null) return;

    // Get current quantity to multiply attribute price
    final currentQty = cartItem.qty ?? 1;

    if (isMultiple) {
      if (selectedList.contains(valueId)) {
        selectedList.remove(valueId);
        cartItem = cartItem.copyWith(
            currentItemPrice: (cartItem.currentItemPrice ?? 0) - ((value.price ?? 0) * currentQty),
            price: (cartItem.price ?? 0) - (value.price ?? 0));
      } else {
        selectedList.add(valueId);
        cartItem = cartItem.copyWith(
            currentItemPrice: (cartItem.currentItemPrice ?? 0) + ((value.price ?? 0) * currentQty),
            price: (cartItem.price ?? 0) + (value.price ?? 0));
      }
    } else {
      final oldValueId = selectedList.isNotEmpty ? selectedList.first : null;

      num oldPrice = 0;
      if (oldValueId != null) {
        final oldValue = attribute.values?.firstWhere(
          (v) => v.attributeValueId == oldValueId,
          orElse: () => throw Exception("Value not found"),
        );
        oldPrice = oldValue?.price ?? 0;
      }

      selectedList
        ..clear()
        ..add(valueId);

      final priceDifference = (value.price ?? 0) - oldPrice;
      final currentPrice = (cartItem.currentItemPrice ?? 0) + (priceDifference * currentQty);
      final unitPrice = (cartItem.price ?? 0) + priceDifference;
      
      cartItem = cartItem.copyWith(
          currentItemPrice: currentPrice, 
          price: unitPrice);
    }
    currentSelections[attributeId] = selectedList;
    selectedValues = currentSelections;

    emit(GetProductDetailsSuccess(
      productModel: cartItem.productModel!,
      cartItem: cartItem,
    ));
  }

  double getTotalExtraPrice(List<AttributesModel> attributes) {
    double total = 0;

    for (final attribute in attributes) {
      final selected = selectedValues[attribute.attributeId] ?? [];
      for (final value in attribute.values ?? []) {
        if (selected.contains(value.attributeValueId)) {
          total += value.price ?? 0;
        }
      }
    }

    return total;
  }
}
