import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/auth/domain/entity/register_params.dart';
import 'package:aslol/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UpdateUserDataUseCase {
  final AuthRepository authRepository;

  UpdateUserDataUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required RegisterParams params}) async {
    return await authRepository.updateUserData(params: params);
  }
}
