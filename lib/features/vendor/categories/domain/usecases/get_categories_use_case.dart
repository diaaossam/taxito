import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../repositories/categories_repository.dart';

@LazySingleton()
class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({required int page}) async {
    return await repository.getCategories(page: page);
  }
}
