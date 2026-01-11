import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

abstract class SettingsRepository {

  Future<Either<Failure, ApiSuccessResponse>> getPageData(
      {required int pageNumber});

  Future<Either<Failure, ApiSuccessResponse>> getFaqs();

  Future<Either<Failure, ApiSuccessResponse>> getAppSettings();

  Future<Either<Failure, ApiSuccessResponse>> getDeletionReasons();

  Future<Either<Failure, ApiSuccessResponse>> changeLangCode(
      {required String langCode});
}
