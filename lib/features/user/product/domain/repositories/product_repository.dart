import 'package:aslol/features/order/data/models/review_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../../../core/services/network/success_response.dart';
import '../../../order/data/models/product_params.dart';

abstract class ProductRepository {
  Future<Either<Failure, ApiSuccessResponse>> toggleWishlist({required num id, required String type});

  Future<Either<Failure, ApiSuccessResponse>> submitReview(
      {required Map<String, dynamic> map});

  Future<Either<Failure, ApiSuccessResponse>> getProducts(
      {required ProductParams params});

  Future<Either<Failure, ApiSuccessResponse>> getProductDetails(
      {required num id, required num supplierId});

  Future<Either<Failure, ApiSuccessResponse>> getFavourite(
      {required int pageKey, required int type});

  Future<Either<Failure, ApiSuccessResponse>> getSuppliersProduct(
      {required ProductParams params});
}
