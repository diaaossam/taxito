import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/features/captain/notifications/data/models/notification_model.dart';
import 'package:taxito/features/captain/notifications/domain/repositories/notification_repository.dart';

@LazySingleton()
class GetNotificationListUseCase {
  final NotificationRepository notificationRepository;

  GetNotificationListUseCase({required this.notificationRepository});

  Future<Either<Failure, List<NotificationModel>>> call(
      {required int pageKey}) {
    return notificationRepository.getNotificationList(pageKey: pageKey);
  }
}
