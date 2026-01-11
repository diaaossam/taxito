import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import '../../../../captain/auth/data/models/request/otp_params.dart';
import '../entity/register_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, ApiSuccessResponse>> logOut();

  Future<Either<Failure, ApiSuccessResponse>> loginUser({
    required String phone,
  });

  Future<Either<Failure, ApiSuccessResponse>> getUserData();

  Future<Either<Failure, ApiSuccessResponse>> deleteUser({required int reason});

  Future<Either<Failure, ApiSuccessResponse>> registerUser({
    required RegisterParams registerParams,
  });

  Future<Either<Failure, ApiSuccessResponse>> verifyOtp({
    required OtpParams otpParams,
  });

  Future<Either<Failure, ApiSuccessResponse>> resendOtp({
    required String phone,
  });

  Future<Either<Failure, ApiSuccessResponse>> updateFcm();

  Future<Either<Failure, ApiSuccessResponse>> getSupplierCategory();
}
