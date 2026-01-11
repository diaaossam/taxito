import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/delivery_orders_repository.dart';

@LazySingleton()
class UpdateDeliveryOrderUseCase {
  final DeliveryOrdersRepository repository;

  UpdateDeliveryOrderUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required num id, required String status}) async {
    return await repository.updateOrderStatus(id: id, status: status);
  }
}
