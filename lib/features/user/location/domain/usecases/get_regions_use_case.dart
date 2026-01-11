import 'package:aslol/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../../../core/services/network/success_response.dart';

@LazySingleton()
class GetRegionUseCase {
  final LocationRepository locationRepository;

  GetRegionUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await locationRepository.getRegion(id: id);
  }
}
