import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/location_repository.dart';

@Injectable()
class UpdateDriverLocationUseCase {
  final LocationRepository locationRepository;

  UpdateDriverLocationUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required num lat, required num lng}) async {
    return await locationRepository.updateDriverLocation(lat: lat, lng: lng);
  }
}
