import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';

import '../repositories/auth_repository.dart';

@LazySingleton()
class GetUserDataUseCase {
  final AuthRepository authRepository;

  GetUserDataUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() {
    return authRepository.getUserData();
  }
}
