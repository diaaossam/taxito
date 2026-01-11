import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/trip_repository.dart';

@Injectable()
class CancelTripUseCase {
  final TripRepository tripRepository;

  CancelTripUseCase({required this.tripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await tripRepository.cancelTrip(id: id);
  }
}
