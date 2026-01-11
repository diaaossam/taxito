import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/trip_repository.dart';

@Injectable()
class GetUserDriverUseCase {
  final TripRepository tripRepository;

  GetUserDriverUseCase({required this.tripRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required LatLng lat,
    required double radius,
  }) async {
    return await tripRepository.getUserDriver(lat: lat, radius: radius);
  }
}
