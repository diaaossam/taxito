import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/request/delivery_order_params.dart';

abstract class DeliveryOrdersRepository {
  Future<Either<Failure, ApiSuccessResponse>> getDeliveryOrder(
      {required DeliveryParams params});

  Future<Either<Failure, ApiSuccessResponse>> getStatics();

  Future<Either<Failure, ApiSuccessResponse>> getOrderDetails(
      {required int id});
  Future<Either<Failure,ApiSuccessResponse>> acceptDeliveryOrder({required num id});
  Future<Either<Failure,ApiSuccessResponse>> rejectDeliveryOrder({required num id});
  Future<Either<Failure,ApiSuccessResponse>> updateOrderStatus({required num id , required String status});
}
