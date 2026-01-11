import 'package:dartz/dartz.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/main/data/datasources/main_remote_data_source.dart';
import 'package:aslol/features/main/domain/repositories/main_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MainRepository)
class MainRepositoryImpl implements MainRepository {
  final MainRemoteDataSource mainRemoteDataSource;

  MainRepositoryImpl({required this.mainRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getAllBanners() async {
    try {
      final response = await mainRemoteDataSource.getAllBanners();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getMainCategories() async {
    try {
      final response = await mainRemoteDataSource.getMainCategories();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getProductsBrandUseCase() async {
    try {
      final response = await mainRemoteDataSource.getProductsBrandUseCase();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateDeviceToken() async {
    try {
      final response = await mainRemoteDataSource.updateDeviceToken();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
