import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetFavouriteUseCase {
  final ProductRepository productRepository;

  GetFavouriteUseCase({required this.productRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required int pageKey, required int type}) async {
    return await productRepository.getFavourite(pageKey: pageKey, type: type);
  }
}
