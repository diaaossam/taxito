import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class LogOutUseCase {
  final AuthRepository authRepository;

  LogOutUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() {
    return authRepository.logOut();
  }
}
