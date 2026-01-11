import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../entities/trip_params.dart';
import '../repositories/trip_repository.dart';

@Injectable()
class MakeTripUseCase {
  final TripRepository tripRepository;

  MakeTripUseCase({required this.tripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required TripParams tripParams,
  }) async {
    return await tripRepository.requestTrip(tripParams: tripParams);
  }
}
