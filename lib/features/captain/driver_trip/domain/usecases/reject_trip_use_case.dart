import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/driver_repository.dart';

@Injectable()
class RejectTripUseCase {
  final DriverTripRepository driverTripRepository;

  RejectTripUseCase({required this.driverTripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required num tripId,
  }) async {
    return driverTripRepository.rejectTrip(tripId: tripId);
  }
}
