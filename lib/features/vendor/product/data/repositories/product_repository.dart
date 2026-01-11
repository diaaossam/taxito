import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/vendor/product/data/datasources/product_remote_data_source.dart';
import 'package:taxito/features/vendor/product/data/models/request/add_product_params.dart';
import 'package:taxito/features/vendor/product/data/models/request/product_params.dart';

@LazySingleton()
class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository({required this.remoteDataSource});

  Future<Either<Failure, ApiSuccessResponse>> addProduct({
    required AddProductParams params,
  }) async {
    try {
      final response = await remoteDataSource.addProduct(params: params);
      return Right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  Future<Either<Failure, ApiSuccessResponse>> getProducts({
    required ProductParams params,
  }) async {
    try {
      final response = await remoteDataSource.getProduct(params: params);
      return Right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  Future<Either<Failure, ApiSuccessResponse>> getReview({
    required num id,
  }) async {
    try {
      final response = await remoteDataSource.getReview(id: id);
      return Right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  Future<Either<Failure, ApiSuccessResponse>> getProduct({
    required num id,
  }) async {
    try {
      final response = await remoteDataSource.getProductData(id: id);
      return Right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  Future<Either<Failure, ApiSuccessResponse>> deleteProduct({
    required num id,
  }) async {
    try {
      final response = await remoteDataSource.deleteProduct(id: id);
      return Right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
