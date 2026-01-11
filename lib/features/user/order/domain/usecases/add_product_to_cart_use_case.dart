import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../data/models/cart_model.dart';
import '../repositories/order_repository.dart';

@LazySingleton()
class AddProductToCartUseCase {
  final OrderRepository orderRepository;

  AddProductToCartUseCase({required this.orderRepository});

  Future<Either<Failure, bool>> call(
      {required List<CartItem> cartProductList}) async {
    return await orderRepository.addProductToCart(
        cartProductList: cartProductList);
  }
}
