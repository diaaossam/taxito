import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../repositories/categories_repository.dart';

@Injectable()
class DeleteCategoryUseCase {
  final CategoriesRepository repository;

  DeleteCategoryUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await repository.deleteCategory(id: id);
  }
}














