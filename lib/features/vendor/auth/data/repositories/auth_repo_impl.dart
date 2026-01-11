import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/entity/register_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/request/otp_params.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> registerUser({
    required RegisterParams registerParams,
  }) async {
    try {
      final response = await authRemoteDataSource.registerUser(
        registerParams: registerParams,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

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
  Future<Either<Failure, ApiSuccessResponse>> deleteUser({
    required int reason,
  }) async {
    try {
      final response = await authRemoteDataSource.deleteUser(reason: reason);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> loginUser({
    required String phone,
  }) async {
    try {
      final response = await authRemoteDataSource.loginUser(phone: phone);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> resendOtp({
    required String phone,
  }) async {
    try {
      final response = await authRemoteDataSource.resendOtp(phone: phone);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateFcm() async {
    try {
      final response = await authRemoteDataSource.updateFcm();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getSupplierCategory() async {
    try {
      final response = await authRemoteDataSource.getSupplierCategory();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
