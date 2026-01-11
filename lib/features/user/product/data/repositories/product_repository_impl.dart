import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/order/data/models/product_params.dart';
import 'package:aslol/features/product/data/datasources/product_remote_data_source.dart';
import 'package:aslol/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> toggleWishlist(
      {required num id, required String type}) async {
    try {
      final response =
          await productRemoteDataSource.toggleWishlist(id: id, type: type);
      return Right(response);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> submitReview(
      {required Map<String, dynamic> map}) async {
    try {
      final response = await productRemoteDataSource.submitReview(map: map);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getProducts(
      {required ProductParams params}) async {
    try {
      final response =
          await productRemoteDataSource.getProducts(params: params);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getProductDetails(
      {required num id, required num supplierId}) async {
    try {
      final response = await productRemoteDataSource.getProductDetails(
          id: id, supplierId: supplierId);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getFavourite(
      {required int pageKey, required int type}) async {
    try {
      final response = await productRemoteDataSource.getFavourite(
          pageKey: pageKey, type: type);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getSuppliersProduct(
      {required ProductParams params}) async {
    try {
      final response =
          await productRemoteDataSource.getSuppliersProduct(params: params);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
