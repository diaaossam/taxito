import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/delivery_order/data/datasources/delivery_remote_data_source.dart';
import 'package:taxito/features/captain/delivery_order/data/models/request/delivery_order_params.dart';
import 'package:taxito/features/captain/delivery_order/domain/repositories/delivery_orders_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeliveryOrdersRepository)
class DeliveryOrdersRepositoryImpl implements DeliveryOrdersRepository {
  final DeliveryRemoteDataSource deliveryRemoteDataSource;

  DeliveryOrdersRepositoryImpl({required this.deliveryRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getDeliveryOrder(
      {required DeliveryParams params}) async {
    try {
      final response =
          await deliveryRemoteDataSource.getDeliveryOrder(params: params);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getStatics() async {
    try {
      final response = await deliveryRemoteDataSource.getStatics();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getOrderDetails(
      {required int id}) async {
    try {
      final response = await deliveryRemoteDataSource.getOrderDetails(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> acceptDeliveryOrder(
      {required num id}) async {
    try {
      final response =
          await deliveryRemoteDataSource.acceptDeliveryOrder(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateOrderStatus(
      {required num id, required String status}) async {
    try {
      final response = await deliveryRemoteDataSource.updateOrderStatus(
          id: id, status: status);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> rejectDeliveryOrder(
      {required num id}) async {
    try {
      final response = await deliveryRemoteDataSource.rejectDeliveryOrder(
        id: id,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
