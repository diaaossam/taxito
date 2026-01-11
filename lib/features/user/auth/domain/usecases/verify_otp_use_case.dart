import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/auth/data/models/request/otp_params.dart';
import 'package:aslol/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton()
class VerifyOtpUseCase {
  final AuthRepository authRepository;

  VerifyOtpUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required OtpParams otpParams}) async {
    return await authRepository.verifyOtp(otpParams: otpParams);
  }
}
