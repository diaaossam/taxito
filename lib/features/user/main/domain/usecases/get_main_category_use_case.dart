import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/main/domain/repositories/main_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetMainCategoryUseCase {
  final MainRepository _mainRepository;

  GetMainCategoryUseCase({required MainRepository mainRepository})
      : _mainRepository = mainRepository;

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await _mainRepository.getMainCategories();
  }
}
