import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class LoginUserUseCase {
  final AuthRepository authRepository;

  LoginUserUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required String phone,
  }) async {
    return await authRepository.loginUser(phone: phone);
  }
}
