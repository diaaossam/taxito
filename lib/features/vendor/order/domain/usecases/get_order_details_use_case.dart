import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/delivery_orders_repository.dart';

@LazySingleton()
class GetOrderDetailsUseCase {
  final DeliveryOrdersRepository orderRepository;

  GetOrderDetailsUseCase({required this.orderRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required int id}) async {
    return await orderRepository.getOrderDetails(id: id);
  }
}
