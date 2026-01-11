import 'package:aslol/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../../../core/services/network/success_response.dart';
import '../../../order/data/models/product_params.dart';

@LazySingleton()
class GetSuppliersProductUseCase {
  final ProductRepository _productRepository;

  GetSuppliersProductUseCase({required ProductRepository productRepository})
      : _productRepository = productRepository;

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required ProductParams params}) async {
    return await _productRepository.getSuppliersProduct(params: params);
  }
}
