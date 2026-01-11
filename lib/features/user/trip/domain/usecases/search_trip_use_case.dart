import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/trip_repository.dart';

@LazySingleton()
class SearchTripUseCase {
  final TripRepository repository;

  SearchTripUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required num tripId,
  }) async => await repository.searchTrip(tripId: tripId);
}
