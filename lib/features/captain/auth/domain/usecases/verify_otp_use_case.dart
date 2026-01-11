import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../data/models/request/otp_params.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class VerifyOtpUseCase {
  final AuthRepository authRepository;

  VerifyOtpUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required OtpParams otpParams}) async {
    return await authRepository.verifyOtp(otpParams: otpParams);
  }
}
