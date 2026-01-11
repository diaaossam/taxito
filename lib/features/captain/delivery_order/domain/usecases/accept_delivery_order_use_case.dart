import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/delivery_order/domain/repositories/delivery_orders_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AcceptDeliveryOrderUseCase {
  final DeliveryOrdersRepository repository;

  AcceptDeliveryOrderUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await repository.acceptDeliveryOrder(id: id);
  }
}
