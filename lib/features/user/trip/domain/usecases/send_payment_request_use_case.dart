import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/trip_repository.dart';

@LazySingleton()
class SendUserPaymentRequestUseCase {
  final TripRepository tripRepository;

  SendUserPaymentRequestUseCase({required this.tripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required num id,
    required String paymentMethod,
  }) async {
    return await tripRepository.sendPaymentUserRequest(
      id: id,
      paymentMethod: paymentMethod,
    );
  }
}
