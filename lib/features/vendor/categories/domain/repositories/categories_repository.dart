import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, ApiSuccessResponse>> getCategories({required int page});

  Future<Either<Failure, ApiSuccessResponse>> addCategory({required Map<String, dynamic> body});

  Future<Either<Failure, ApiSuccessResponse>> updateCategory({required num id, required Map<String, dynamic> body});

  Future<Either<Failure, ApiSuccessResponse>> deleteCategory({required num id});
}



