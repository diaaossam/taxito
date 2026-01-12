import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class DeleteAccountUseCase {
  final AuthRepository authRepository;

  DeleteAccountUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return authRepository.deleteUser();
  }
}
