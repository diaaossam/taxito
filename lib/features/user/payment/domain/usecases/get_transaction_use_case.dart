import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/payment/domain/repositories/payment_repository.dart';
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
