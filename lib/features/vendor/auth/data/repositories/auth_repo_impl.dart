import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/enum/user_type.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../../captain/auth/data/models/request/otp_params.dart';
import '../../domain/entity/register_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import 'package:taxito/features/captain/auth/data/datasources/auth_remote_data_source.dart'
    as captain_ds;

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final captain_ds.AuthRemoteDataSource captain;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.captain,
  });

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
      final response = await captain.verifyOtp(otpParams: otpParams);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getUserData() async {
    try {
      final response = await captain.getUserData();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> logOut() async {
    try {
      final response = await captain.logOut();
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
      final response = await captain.deleteUser(reason: reason);
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
      final response = await captain.resendOtp(
        phone: phone,
        userType: UserType.supplier,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateFcm() async {
    try {
      final response = await captain.updateFcm();
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
