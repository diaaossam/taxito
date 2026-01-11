import 'package:aslol/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../../../core/services/network/success_response.dart';

@LazySingleton()
class GetGovernoratesUseCase {
  final LocationRepository locationRepository;

  GetGovernoratesUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await locationRepository.getGovernorates();
  }
}
