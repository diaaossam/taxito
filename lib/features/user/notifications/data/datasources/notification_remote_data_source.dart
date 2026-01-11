import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/dio_consumer.dart';
import 'package:aslol/core/services/network/end_points.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/notifications/data/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotificationList({required int pageKey});

  Future<ApiSuccessResponse> markAllAsRead();

  Future<ApiSuccessResponse> getNotificationCount();
}

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioConsumer dioConsumer;

  NotificationRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<List<NotificationModel>> getNotificationList(
      {required int pageKey}) async {
    List<NotificationModel> list = [];
    final response = await dioConsumer.get(path: EndPoints.notfications);

    response['data'].forEach((element) {
      NotificationModel notificationModel = NotificationModel.fromJson(element);
      list.add(notificationModel);
    });
    return list;
  }

  @override
  Future<ApiSuccessResponse> markAllAsRead() async {
    await dioConsumer.post(
      path: EndPoints.markAllAsRead,
    );
    return ApiSuccessResponse();
  }

  @override
  Future<ApiSuccessResponse> getNotificationCount() async {
    final response = await dioConsumer.get(
      path: EndPoints.notificationCount,
    );
    return ApiSuccessResponse(data: response['data']['un_read_notifications']);
  }
}
