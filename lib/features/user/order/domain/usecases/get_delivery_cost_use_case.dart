import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/order/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetDeliveryCostUseCase {
  final OrderRepository orderRepository;

  GetDeliveryCostUseCase({required this.orderRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required num supplierId}) async {
    return await orderRepository.getLocationCost(supplierId: supplierId);
  }
}
