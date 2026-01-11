import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetProductDetailsUseCase {
  final ProductRepository productRepository;

  GetProductDetailsUseCase({required this.productRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required num id, required num supplierId}) async {
    return await productRepository.getProductDetails(
        id: id, supplierId: supplierId);
  }
}
