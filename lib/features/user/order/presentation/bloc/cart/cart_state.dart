part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class AddCartListStateLoading extends CartState {}

class AddCartListStateSuccess extends CartState {}

class GetCartListLoading extends CartState {}

class GetCartListState extends CartState {}
class InitCachedCouponCode extends CartState {
  final String code;

  InitCachedCouponCode({required this.code});
}

class SetQuantityStateSuccess extends CartState {}

class DeleteItemFromCartLoading extends CartState {}

class DeleteItemFromCartSuccess extends CartState {}

class DeleteItemFromCartFailure extends CartState {}

class DeleteCouponToCartSuccess extends CartState {}

class PlaceOrderLoading extends CartState {}

class PlaceOrderSuccess extends CartState {
  final int orderId;

  PlaceOrderSuccess({required this.orderId});
}

class PlaceOrderFailure extends CartState {
  final String msg;

  PlaceOrderFailure({required this.msg});
}

class ApplyCouponToCartLoading extends CartState {}

class ApplyCouponToCartSuccess extends CartState {
  final CouponModel couponModel;

  ApplyCouponToCartSuccess({required this.couponModel});
}

class ApplyCouponToCartFailure extends CartState {
  final String error;

  ApplyCouponToCartFailure({required this.error});
}

class UpdateCartList extends CartState {}

class DifferentSupplierWarning extends CartState {
  final CartItem newItem;
  final String currentSupplierName;
  final String newSupplierName;

  DifferentSupplierWarning({
    required this.newItem,
    required this.currentSupplierName,
    required this.newSupplierName,
  });
}

