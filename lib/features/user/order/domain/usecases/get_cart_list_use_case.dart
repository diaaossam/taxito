import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../data/models/cart_model.dart';
import '../repositories/order_repository.dart';

@LazySingleton()
class GetCartListUse {
  final OrderRepository orderRepository;

  GetCartListUse({required this.orderRepository});

  Future<Either<Failure, List<CartItem>>> call({required bool isRemote}) async {
    return await orderRepository.getCartList(isRemote: isRemote);
  }
}
