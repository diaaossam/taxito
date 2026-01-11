import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/trip_repository.dart';

@LazySingleton()
class GetTripByIdUseCase {
  final TripRepository driverTripRepository;

  GetTripByIdUseCase({required this.driverTripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async =>
      driverTripRepository.getTripById(id: id);
}
