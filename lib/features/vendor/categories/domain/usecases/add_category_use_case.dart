import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../repositories/categories_repository.dart';

@Injectable()
class AddCategoryUseCase {
  final CategoriesRepository repository;

  AddCategoryUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required Map<String, dynamic> body,
  }) async {
    return await repository.addCategory(body: body);
  }
}
