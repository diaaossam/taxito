import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/driver_repository.dart';

@Injectable()
class AcceptDriverPaymentRequestUseCase {
  final DriverTripRepository driverTripRepository;

  AcceptDriverPaymentRequestUseCase({required this.driverTripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required num id, required bool driverAcceptConfirmation}) async {
    return await driverTripRepository.acceptDriverPaymentRequest(
        id: id, driverAcceptConfirmation: driverAcceptConfirmation);
  }
}
