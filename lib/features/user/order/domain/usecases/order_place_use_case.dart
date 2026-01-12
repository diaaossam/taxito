import 'package:taxito/features/user/order/data/models/cart_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/order_repository.dart';

@LazySingleton()
class OrderPlaceUseCase {
  final OrderRepository orderRepository;

  OrderPlaceUseCase({required this.orderRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required CartModel placeOrderModel,
  }) async =>
      await orderRepository.placeOrder(placeOrderModel: placeOrderModel);
}
