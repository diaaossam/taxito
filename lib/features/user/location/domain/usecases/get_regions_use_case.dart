import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';

import '../../../../../core/services/network/success_response.dart';
import '../repositories/location_repository.dart';

@LazySingleton()
class GetRegionUseCase {
  final LocationRepository locationRepository;

  GetRegionUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await locationRepository.getRegion(id: id);
  }
}
