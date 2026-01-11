import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../data/models/cart_model.dart';
import '../repositories/order_repository.dart';

@LazySingleton()
class DeleteProductToCartUseCase {
  final OrderRepository orderRepository;

  DeleteProductToCartUseCase({required this.orderRepository});

  Future<Either<Failure, bool>> call({
    required List<CartItem> cartProductList,
    required String id,
  }) async {
    return await orderRepository.deleteProductToCart(
      cartProductList: cartProductList,
      id: id,
    );
  }
}
