import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/location/data/models/requests/location_params.dart';
import 'package:taxito/features/user/location/domain/repositories/location_repository.dart';
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
