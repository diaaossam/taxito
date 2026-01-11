import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/auth_repository.dart';

@LazySingleton()
class GetSupplierCategoryUseCase {
  final AuthRepository authRepository;

  GetSupplierCategoryUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await authRepository.getSupplierCategory();
  }
}
