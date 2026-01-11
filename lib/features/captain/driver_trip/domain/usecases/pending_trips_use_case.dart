import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/driver_repository.dart';

@LazySingleton()
class PendingTripsUseCase {
  final DriverTripRepository repository;

  PendingTripsUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await repository.getPendingTrips();
  }
}
