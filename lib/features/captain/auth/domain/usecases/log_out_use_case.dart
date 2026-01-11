import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class LogOutUseCase {
  final AuthRepository authRepository;

  LogOutUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() {
    return authRepository.logOut();
  }
}
