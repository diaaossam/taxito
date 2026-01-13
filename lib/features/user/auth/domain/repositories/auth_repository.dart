import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/auth/data/models/request/otp_params.dart';
import 'package:taxito/features/common/models/register_params.dart';

import '../../data/models/request/login_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, ApiSuccessResponse>> logOut();

  Future<Either<Failure, ApiSuccessResponse>> loginUser({
    required LoginParams params,
  });

  Future<Either<Failure, ApiSuccessResponse>> getUserData();

  Future<Either<Failure, ApiSuccessResponse>> deleteUser();

  Future<Either<Failure, ApiSuccessResponse>> verifyOtp({
    required OtpParams otpParams,
  });

  Future<Either<Failure, ApiSuccessResponse>> updateUserData({
    required RegisterParams params,
  });
}
