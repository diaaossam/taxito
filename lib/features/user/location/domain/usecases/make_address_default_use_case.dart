import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:aslol/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class MakeAddressDefaultUseCase {
  final LocationRepository _locationRepository;

  MakeAddressDefaultUseCase({required LocationRepository locationRepository})
      : _locationRepository = locationRepository;

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required MyAddress myAddress}) async {
    return await _locationRepository.makeAddressDefault(myAddress: myAddress);
  }
}
