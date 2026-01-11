import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/delivery_orders_repository.dart';

@LazySingleton()
class RejectDeliveryOrderUseCase {
  final DeliveryOrdersRepository repository;

  RejectDeliveryOrderUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await repository.rejectDeliveryOrder(id: id);
  }
}
