import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetAddressUseCase {
  final LocationRepository locationRepository;

  GetAddressUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await locationRepository.getMyAddress();
  }
}
