import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_data_source.dart';

@LazySingleton(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getCategories({
    required int page,
  }) async {
    try {
      final res = await remoteDataSource.getCategories(pageKey: page);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> addCategory({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await remoteDataSource.addCategory(body: body);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateCategory({
    required num id,
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await remoteDataSource.updateCategory(id: id, body: body);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> deleteCategory({
    required num id,
  }) async {
    try {
      final res = await remoteDataSource.deleteCategory(id: id);
      return right(res);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
