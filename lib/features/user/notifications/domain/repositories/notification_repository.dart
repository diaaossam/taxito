import 'package:dartz/dartz.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/notifications/data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationModel>>> getNotificationList({required int pageKey});

  Future<Either<Failure, ApiSuccessResponse>> markAllAsRead();
  Future<Either<Failure, ApiSuccessResponse>> getNotificationCount();
}
