import 'package:dartz/dartz.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/auth/data/models/request/otp_params.dart';
import 'package:aslol/features/auth/domain/entity/register_params.dart';

import '../../data/models/request/login_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, ApiSuccessResponse>> logOut();

  Future<Either<Failure, ApiSuccessResponse>> loginUser(
      {required LoginParams params});

  Future<Either<Failure, ApiSuccessResponse>> getUserData();

  Future<Either<Failure, ApiSuccessResponse>> deleteUser();

  Future<Either<Failure, ApiSuccessResponse>> verifyOtp(
      {required OtpParams otpParams});

  Future<Either<Failure, ApiSuccessResponse>> updateUserData(
      {required RegisterParams params});
}
