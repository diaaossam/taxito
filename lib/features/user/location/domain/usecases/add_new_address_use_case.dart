import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/location/data/models/requests/location_params.dart';
import 'package:aslol/features/location/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AddNewAddressUseCase {
  final LocationRepository locationRepository;

  AddNewAddressUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required SavedLocationParams params, num? id}) async {
    return await locationRepository.addNewAddress(params: params, id: id);
  }
}
