import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../repositories/attributes_repository.dart';

@LazySingleton()
class GetAttributesUseCase {
  final AttributesRepository repository;

  GetAttributesUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({required int page}) async {
    return await repository.getAttributes(page: page);
  }
}
