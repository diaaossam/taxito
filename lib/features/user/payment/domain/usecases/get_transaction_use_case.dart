import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/payment/domain/repositories/payment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetTransactionUseCase {
  final PaymentRepository paymentRepository;

  GetTransactionUseCase({required this.paymentRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required int pageKey}) async {
    return await paymentRepository.getTransaction(pageKey: pageKey);
  }
}
