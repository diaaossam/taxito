import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/internet_checker/netwok_info.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:aslol/features/notifications/data/models/notification_model.dart';
import 'package:aslol/features/notifications/domain/repositories/notification_repository.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NetworkInfo networkInfo;
  final NotificationRemoteDataSource remoteMainDataSource;

  NotificationRepositoryImpl({
    required this.networkInfo,
    required this.remoteMainDataSource,
  });

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotificationList(
      {required int pageKey}) async {
    try {
      final response =
          await remoteMainDataSource.getNotificationList(pageKey: pageKey);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> markAllAsRead() async {
    try {
      final response = await remoteMainDataSource.markAllAsRead();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getNotificationCount() async {
    try {
      final response = await remoteMainDataSource.getNotificationCount();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
