import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/driver_repository.dart';

@Injectable()
class AcceptTripUseCase {
  final DriverTripRepository driverTripRepository;

  AcceptTripUseCase({required this.driverTripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required num tripId}) async {
    return driverTripRepository.acceptTrip(tripId: tripId);
  }
}
