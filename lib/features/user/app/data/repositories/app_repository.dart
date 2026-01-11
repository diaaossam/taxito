import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/app/data/datasources/app_remote_data_source.dart';
import 'package:aslol/features/app/domain/repositories/app_repository.dart';

@LazySingleton(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  final AppRemoteDataSource appRemoteDataSource;

  AppRepositoryImpl({required this.appRemoteDataSource});

  @override
  Future<Either<Failure, String>> uploadImage({required File file}) async {
    try {
      final response = await appRemoteDataSource.uploadImage(file: file);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> generateDeepLink(
      {required int id}) async {
    try {
      final response = await appRemoteDataSource.generateDeepLink(id: id);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> deleteImage(
      {required int id}) async {
    try {
      final response = await appRemoteDataSource.deleteImage(id: id);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
