import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetUserDataUseCase {
  final AuthRepository authRepository;

  GetUserDataUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await authRepository.getUserData();
  }
}
