import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/notifications/data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationModel>>> getNotificationList({required int pageKey});

  Future<Either<Failure, ApiSuccessResponse>> markAllAsRead();
  Future<Either<Failure, ApiSuccessResponse>> getNotificationCount();
}
