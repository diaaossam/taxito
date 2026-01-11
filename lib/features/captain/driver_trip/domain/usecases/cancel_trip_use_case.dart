import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../data/models/trip_model.dart';
import '../repositories/driver_repository.dart';

@Injectable()
class CancelDriverTripUseCase {
  final DriverTripRepository driverTripRepository;

  CancelDriverTripUseCase({required this.driverTripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required TripModel tripModel}) async {
    return await driverTripRepository.cancelTrip(tripModel: tripModel);
  }
}
