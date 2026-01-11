import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/notifications/domain/repositories/notification_repository.dart';

@LazySingleton()
class MarkAllAsReadUseCase {
  final NotificationRepository notificationRepository;

  MarkAllAsReadUseCase({required this.notificationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await notificationRepository.markAllAsRead();
  }
}
