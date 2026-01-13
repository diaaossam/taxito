import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/features/captain/delivery_order/data/models/response/statics_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/models/user_type_helper.dart';
import '../../../../../core/services/network/success_response.dart';
import '../models/request/delivery_order_params.dart';
import 'package:taxito/core/data/models/orders.dart';

abstract class DeliveryRemoteDataSource {
  Future<ApiSuccessResponse> getDeliveryOrder({required DeliveryParams params});

  Future<ApiSuccessResponse> getStatics();

  Future<ApiSuccessResponse> getOrderDetails({required int id});

  Future<ApiSuccessResponse> acceptDeliveryOrder({required num id});

  Future<ApiSuccessResponse> rejectDeliveryOrder({required num id});

  Future<ApiSuccessResponse> updateOrderStatus({
    required num id,
    required String status,
  });
}

@LazySingleton(as: DeliveryRemoteDataSource)
class DeliveryRemoteDataSourceImpl implements DeliveryRemoteDataSource {
  final DioConsumer dioConsumer;

  DeliveryRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getDeliveryOrder({
    required DeliveryParams params,
  }) async {
    final response = await dioConsumer.get(
      path: params.status == OrderType.pending
          ? EndPoints.pendingOrders
          : EndPoints.orders,
      params: params.toJson(),
    );
    final List<Orders> list = response['data']
        .map<Orders>((element) => Orders.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> getStatics() async {
    final response = await dioConsumer.get(
      path: EndPoints.statistics(UserTypeService().getUserType()!),
    );
    return ApiSuccessResponse(data: StaticsModel.fromJson(response['data']));
  }

  @override
  Future<ApiSuccessResponse> getOrderDetails({required int id}) async {
    final response = await dioConsumer.get(path: "${EndPoints.orders}/$id");
    Orders orders = Orders.fromJson(response['data']);
    return ApiSuccessResponse(data: orders);
  }

  @override
  Future<ApiSuccessResponse> acceptDeliveryOrder({required num id}) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.acceptOrder}/$id",
    );
    return ApiSuccessResponse(data: Orders.fromJson(response['data']));
  }

  @override
  Future<ApiSuccessResponse> updateOrderStatus({
    required num id,
    required String status,
  }) async {
    final response = await dioConsumer.put(
      path: "${EndPoints.orders}/$id",
      body: {"delivery_status": status},
    );
    return ApiSuccessResponse(data: Orders.fromJson(response['data']));
  }

  @override
  Future<ApiSuccessResponse> rejectDeliveryOrder({required num id}) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.rejectOrder}/$id",
    );
    return ApiSuccessResponse(data: Orders.fromJson(response['data']));
  }
}
