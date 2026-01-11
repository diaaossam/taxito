part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class GetProductDetailsLoading extends ProductDetailsState {}

final class GetProductDetailsFailure extends ProductDetailsState {
  final String msg;

  GetProductDetailsFailure({required this.msg});
}

final class GetProductDetailsSuccess extends ProductDetailsState {
  final CartItem cartItem;
  final ProductModel productModel;

  GetProductDetailsSuccess(
      {required this.cartItem, required this.productModel});
}

final class UpdateCartItemState extends ProductDetailsState {
  final CartItem cartItem;

  UpdateCartItemState({required this.cartItem});
}

final class ToggleWishlistLoading extends ProductDetailsState {}

final class ToggleWishlistSuccess extends ProductDetailsState {}

final class ToggleWishlistFailure extends ProductDetailsState {
  final String msg;

  ToggleWishlistFailure({required this.msg});
}
