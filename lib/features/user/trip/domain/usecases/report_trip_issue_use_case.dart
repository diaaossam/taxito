import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/models/trip_model.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/trip_repository.dart';

@Injectable()
class ReportTripIssueUseCase {
  final TripRepository _tripRepository;

  ReportTripIssueUseCase(this._tripRepository);

  Future<Either<Failure, ApiSuccessResponse>> call({
    required String msg,
    required TripModel tripModel,
  }) async {
    return await _tripRepository.reportIssue(msg: msg, tripModel: tripModel);
  }
}
