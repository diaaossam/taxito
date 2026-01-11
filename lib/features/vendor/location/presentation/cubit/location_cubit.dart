import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/location/location_permission_service.dart';

part 'location_state.dart';

@Injectable()
class LocationCubit extends Cubit<LocationState> {
  LatLng? latLng;

  LocationCubit() : super(LocationInitial());

  final LocationPermissionService _locationService =
      LocationPermissionService();

  Future<void> requestLocation() async {
    emit(GetLocationLoading());
    final result = await _locationService.requestPermissionAndLocation();

    switch (result.status) {
      case LocationPermissionStatus.granted:
        if (result.location != null) {
          latLng = result.location;
          emit(GetLocationSuccess(latLng: result.location!));
        } else {
          emit(const GetLocationFailure(error: 'Failed to get location'));
        }
        break;

      case LocationPermissionStatus.denied:
        emit(const LocationPermissionDenied(isPermanentlyDenied: false));
        break;

      case LocationPermissionStatus.deniedForever:
        emit(const LocationPermissionDenied(isPermanentlyDenied: true));
        break;

      case LocationPermissionStatus.serviceDisabled:
        emit(const GetLocationFailure(error: 'Location service is disabled'));
        break;
    }
  }

  Future<void> openSettings() async {
    await _locationService.openLocationSettings();
  }

  Future<void> pickLocation({required LatLng lat}) async {
    latLng = lat;
    emit(PickLocationState(latLng: lat));
  }
}
