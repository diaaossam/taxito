import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/driver_trip/domain/repositories/driver_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/enum/trip_status_enum.dart';

@LazySingleton()
class UpdateTripStatusUseCase {
  final DriverTripRepository driverTripRepository;

  UpdateTripStatusUseCase({required this.driverTripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required num id, required TripStatusEnum status}) async {
    return await driverTripRepository.updateStatus(id: id, status: status);
  }
}
