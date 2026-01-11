import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/trip_repository.dart';

@Injectable()
class GetTripByUUidUseCase {
  final TripRepository driverTripRepository;

  GetTripByUUidUseCase({required this.driverTripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required String uuid,
  }) async {
    return driverTripRepository.getTripByUuid(
      uuid: uuid,
    );
  }
}
