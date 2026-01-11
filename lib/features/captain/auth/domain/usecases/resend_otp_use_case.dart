import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/enum/user_type.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class ResendOtpUseCase {
  final AuthRepository authRepository;

  ResendOtpUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required String phone, required UserType userType}) async {
    return authRepository.resendOtp(phone: phone, userType: userType);
  }
}
