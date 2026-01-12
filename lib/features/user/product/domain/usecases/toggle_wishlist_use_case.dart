import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/product_repository.dart';

@LazySingleton()
class ToggleWishlistUseCase {
  final ProductRepository productRepository;

  ToggleWishlistUseCase({required this.productRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required num id, required String type}) async {
    return await productRepository.toggleWishlist(id: id, type: type);
  }
}
