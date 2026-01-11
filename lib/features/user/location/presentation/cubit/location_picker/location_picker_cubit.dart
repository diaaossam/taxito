import 'package:aslol/core/services/location/location_manager.dart';
import 'package:aslol/core/services/location/location_permission_service.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'location_picker_state.dart';

@Injectable()
class LocationPickerCubit extends Cubit<LocationPickerState> {
  LocationPickerCubit() : super(LocationPickerInitial());

  LatLng? currentLocation;

  final Set<Marker> markers = <Marker>{};
  String address = "";

  Future<void> initLocationService({MyAddress? initAddress}) async {
    try {
      emit(InitLocationServiceLoading());
      final result = await LocationPermissionService().requestPermissionAndLocation();
      if (result != null) {
        if (initAddress != null) {
          currentLocation = LatLng(double.parse(initAddress.lat.toString()), double.parse(initAddress.lng.toString()));
          address = initAddress.address??"";

        } else {
          currentLocation = result;
          address = await LocationManager.getMyAddress(latLng: result);

        }
        markers.add(Marker(
            markerId: const MarkerId("Me"),
            position: result,
            icon: BitmapDescriptor.defaultMarker));
        emit(InitLocationServiceSuccess());
      } else {
        emit(InitLocationServiceFailure());
      }
    } catch (error) {
      emit(InitLocationServiceFailure());
    }
  }

  Future<void> changeLocation({required LatLng value}) async {
    address = await LocationManager.getMyAddress(latLng: value);
    markers.clear();
    currentLocation = value;
    markers.add(Marker(
        markerId: const MarkerId("Me"),
        position: value,
        icon: BitmapDescriptor.defaultMarker));
    emit(ChangeUserLocationOnMapState());
  }
}
