import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../../../../captain/auth/data/models/request/otp_params.dart';
import '../../domain/entity/register_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/request/login_params.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> verifyOtp({
    required OtpParams otpParams,
  }) async {
    try {
      final response = await authRemoteDataSource.verifyOtp(
        otpParams: otpParams,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getUserData() async {
    try {
      final response = await authRemoteDataSource.getUserData();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> logOut() async {
    try {
      final response = await authRemoteDataSource.logOut();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> deleteUser() async {
    try {
      final response = await authRemoteDataSource.deleteUser();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> loginUser({
    required LoginParams params,
  }) async {
    try {
      final response = await authRemoteDataSource.loginUser(params: params);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateUserData({
    required RegisterParams params,
  }) async {
    try {
      final response = await authRemoteDataSource.updateUserData(
        params: params,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
