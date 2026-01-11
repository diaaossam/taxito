part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductActionLoading extends ProductState {
  final bool isGetProduct;

  ProductActionLoading({required this.isGetProduct});
}

class ProductActionSuccess extends ProductState {
  final String msg;
  final ProductModel? productModel;
  final bool isInit;

  const ProductActionSuccess({
    required this.msg,
    this.productModel,
    this.isInit = false,
  });

  @override
  List<Object> get props => [msg, isInit];
}

class ProductActionFailure extends ProductState {
  final String msg;

  const ProductActionFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}
