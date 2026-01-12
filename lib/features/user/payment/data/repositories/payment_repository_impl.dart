import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/payment/data/datasources/payment_remote_data_source.dart';
import 'package:taxito/features/user/payment/domain/repositories/payment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource paymentRemoteDataSource;

  PaymentRepositoryImpl({required this.paymentRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getTransaction(
      {required int pageKey}) async {
    try {
      final response =
          await paymentRemoteDataSource.getTransaction(pageKey: pageKey);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> addBalance(
      {required num data}) async {
    try {
      final response = await paymentRemoteDataSource.addBalance(data: data);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getCurrentBalance() async {
    try {
      final response = await paymentRemoteDataSource.getCurrentBalance();
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
