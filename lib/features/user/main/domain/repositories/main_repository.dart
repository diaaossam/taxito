import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

abstract class MainRepository {
  Future<Either<Failure, ApiSuccessResponse>> getAllBanners();

  Future<Either<Failure, ApiSuccessResponse>> getMainCategories();
  Future<Either<Failure, ApiSuccessResponse>> updateDeviceToken();
}
