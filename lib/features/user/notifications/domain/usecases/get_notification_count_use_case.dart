import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/notifications/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetNotificationsCount {
  final NotificationRepository repository;

  GetNotificationsCount({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await repository.getNotificationCount();
  }
}
