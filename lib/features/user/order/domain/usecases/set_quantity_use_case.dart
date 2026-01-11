import 'package:injectable/injectable.dart';
import '../../data/models/cart_model.dart';
import '../repositories/order_repository.dart';

@LazySingleton()
class SetQuantityUseCase {
  final OrderRepository orderRepository;

  SetQuantityUseCase({required this.orderRepository});

  List<CartItem> call(
      {required List<CartItem> cartProductList,
      required String productId,
      required bool isIncrease}) {
    return orderRepository.setQuantity(
        cartProductList: cartProductList,
        productId: productId,
        isIncrease: isIncrease);
  }
}
