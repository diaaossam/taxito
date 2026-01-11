import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:aslol/features/settings/domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource settingsRemoteDataSource;

  SettingsRepositoryImpl({required this.settingsRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getAllSuggestionType() async {
    try {
      final response = await settingsRemoteDataSource.getAllSuggestionType();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> sendSuggestionType(
      {required int id, String? other}) async {
    try {
      final response = await settingsRemoteDataSource.sendSuggestionType(
          id: id, other: other);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getPageData(
      {required int pageNumber}) async {
    try {
      final response =
          await settingsRemoteDataSource.getPageData(pageNumber: pageNumber);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getFaqs() async {
    try {
      final response = await settingsRemoteDataSource.getFaqs();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getAppSettings() async {
    try {
      final response = await settingsRemoteDataSource.getAppSettings();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getDeletionReasons() async {
    try {
      final response = await settingsRemoteDataSource.getDeletionReasons();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> changeLangCode(
      {required String langCode}) async {
    try {
      final response =
          await settingsRemoteDataSource.changeLangCode(langCode: langCode);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
