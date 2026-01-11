import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/driver_repository.dart';

@Injectable()
class GetAllTripsHistoryUseCase {
  final DriverTripRepository _driverTripRepository;

  GetAllTripsHistoryUseCase(this._driverTripRepository);

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required String status, required int pageKey}) async {
    return await _driverTripRepository.getAllTrips(
        pageKey: pageKey, status: status);
  }
}
