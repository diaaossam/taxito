import 'package:taxito/features/user/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';

@LazySingleton()
class SubmitReviewUseCase {
  final ProductRepository productRepository;

  SubmitReviewUseCase({required this.productRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required Map<String, dynamic> map,
  }) async {
    return await productRepository.submitReview(map: map);
  }
}
