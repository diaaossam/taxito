import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/trip_repository.dart';

@Injectable()
class GetAllTripsHistoryUseCase {
  final TripRepository _tripRepository;

  GetAllTripsHistoryUseCase(this._tripRepository);

  Future<Either<Failure, ApiSuccessResponse>> call({
    required String status,
    required int pageKey,
    required bool isSch,
  }) async {
    return await _tripRepository.getAllTrips(
      pageKey: pageKey,
      status: status,
      isSch: isSch,
    );
  }
}
