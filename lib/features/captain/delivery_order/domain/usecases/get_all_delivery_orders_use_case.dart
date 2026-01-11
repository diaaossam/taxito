import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/delivery_order/data/models/request/delivery_order_params.dart';
import 'package:taxito/features/captain/delivery_order/domain/repositories/delivery_orders_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAllDeliveryOrdersUseCase {
  final DeliveryOrdersRepository deliveryOrdersRepository;

  GetAllDeliveryOrdersUseCase({required this.deliveryOrdersRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required DeliveryParams params}) async {
    return await deliveryOrdersRepository.getDeliveryOrder(params: params);
  }
}
