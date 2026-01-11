import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DeleteAddressUseCase {
  final LocationRepository locationRepository;

  DeleteAddressUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await locationRepository.deleteAddress(id: id);
  }
}
