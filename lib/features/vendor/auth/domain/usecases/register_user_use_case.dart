import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../entity/register_params.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class RegisterUserUseCase {
  final AuthRepository authRepository;

  RegisterUserUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required RegisterParams registerParams}) async {
    return await authRepository.registerUser(registerParams: registerParams);
  }
}
