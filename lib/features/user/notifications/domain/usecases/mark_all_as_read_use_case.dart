import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/notifications/domain/repositories/notification_repository.dart';

@LazySingleton()
class MarkAllAsReadUseCase {
  final NotificationRepository notificationRepository;

  MarkAllAsReadUseCase({required this.notificationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await notificationRepository.markAllAsRead();
  }
}
