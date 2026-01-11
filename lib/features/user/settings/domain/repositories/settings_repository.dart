import 'package:dartz/dartz.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';

abstract class SettingsRepository {
  Future<Either<Failure, ApiSuccessResponse>> getAllSuggestionType();

  Future<Either<Failure, ApiSuccessResponse>> sendSuggestionType(
      {required int id, String? other});

  Future<Either<Failure, ApiSuccessResponse>> getPageData(
      {required int pageNumber});

  Future<Either<Failure, ApiSuccessResponse>> getFaqs();

  Future<Either<Failure, ApiSuccessResponse>> getAppSettings();

  Future<Either<Failure, ApiSuccessResponse>> getDeletionReasons();

  Future<Either<Failure, ApiSuccessResponse>> changeLangCode(
      {required String langCode});
}
