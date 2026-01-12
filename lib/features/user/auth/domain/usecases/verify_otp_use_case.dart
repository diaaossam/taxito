import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/auth/domain/repositories/auth_repository.dart';

import '../../../../captain/auth/data/models/request/otp_params.dart';

@LazySingleton()
class VerifyOtpUseCase {
  final AuthRepository authRepository;

  VerifyOtpUseCase({required this.authRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required OtpParams otpParams,
  }) async {
    return await authRepository.verifyOtp(otpParams: otpParams);
  }
}
