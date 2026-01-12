import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/order/data/models/product_params.dart';
import 'package:taxito/features/user/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetProductUseCase {
  final ProductRepository _productRepository;

  GetProductUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required ProductParams params}) async {
    return await _productRepository.getProducts(params: params);
  }
}
