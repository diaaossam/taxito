import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/location_repository.dart';

@Injectable()
class GetPlaceDetailsByLatlng {
  final LocationRepository locationRepository;

  GetPlaceDetailsByLatlng({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required LatLng latlng,
  }) async {
    return await locationRepository.getPlaceDetailsByLatlng(latlng: latlng);
  }
}
