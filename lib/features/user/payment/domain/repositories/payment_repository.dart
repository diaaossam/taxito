import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepository {
  Future<Either<Failure, ApiSuccessResponse>> getTransaction(
      {required int pageKey});

  Future<Either<Failure, ApiSuccessResponse>> addBalance({required num data});
  Future<Either<Failure,ApiSuccessResponse>> getCurrentBalance();
}
