import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../entities/review_trip_params.dart';
import '../repositories/trip_repository.dart';

@Injectable()
class SendTripReviewUseCase {
  final TripRepository _tripRepository;

  SendTripReviewUseCase(this._tripRepository);

  Future<Either<Failure, ApiSuccessResponse>> call({
    required ReviewTripParams reviewParams,
  }) async {
    return _tripRepository.sendTripReview(reviewParams: reviewParams);
  }
}
