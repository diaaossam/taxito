import 'package:aslol/core/services/location/location_manager.dart';
import 'package:aslol/features/location/data/models/requests/location_params.dart';
import 'package:aslol/features/location/domain/usecases/add_new_address_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/services/location/location_permission_service.dart';

part 'add_new_address_state.dart';

@Injectable()
class AddNewAddressCubit extends Cubit<AddNewAddressState> {
  final AddNewAddressUseCase addNewAddressUseCase;

  AddNewAddressCubit(this.addNewAddressUseCase) : super(AddNewAddressInitial());

  Future<void> addNewAddress(
      {required SavedLocationParams saved, num? id}) async {
    emit(AddNewAddressLoading());
    LatLng? lng;
    if (saved.lat == null || saved.lng == null) {
      lng = await LocationPermissionService().requestPermissionAndLocation();
    }

    final address = await LocationManager.getMyAddress(
        latLng: lng ?? LatLng(saved.lat!, saved.lng!));
    SavedLocationParams savedLocationParams =
        saved.copyWith(isDefault: 1, address: address);
    final response =
        await addNewAddressUseCase(params: savedLocationParams, id: id);
    response.fold(
      (failure) => emit(AddNewAddressFailure(msg: failure.msg)),
      (data) {
        emit(AddNewAddressSuccess(msg: data.message ?? ""));
      },
    );
  }
}
