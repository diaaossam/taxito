import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/order/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DeleteOrderUseCase {
  final OrderRepository orderRepository;

  DeleteOrderUseCase({required this.orderRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await orderRepository.deleteOrder(id: id);
  }
}
