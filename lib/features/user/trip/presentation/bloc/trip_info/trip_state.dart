import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/models/main_location_data.dart';

abstract class TripState extends Equatable {
  const TripState();

  @override
  List<Object> get props => [];
}

class TripInitial extends TripState {}

class GetCurrentLocationLoadingState extends TripState {}

class GetCurrentLocationSuccessState extends TripState {}
class GetCurrentLocationSuccess2State extends TripState {}
class GetCurrentLocationSuccess3State extends TripState {}

class GetCurrentLocationFailureState extends TripState {
  final String errorMsg;

  const GetCurrentLocationFailureState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class SubmitTripPointSuccessSuccess extends TripState {
  final bool isStart;
  final MainLocationData locationData;

  const SubmitTripPointSuccessSuccess(
      {required this.isStart, required this.locationData});

  @override
  List<Object> get props => [isStart, locationData];
}

class OnGoogleMapControllerCreatedState extends TripState {}

class TrackDriverLocationState extends TripState {
  final double lat;
  final double lng;

  const TrackDriverLocationState({required this.lat, required this.lng});

  @override
  List<Object> get props => [lat, lng];
}

class ChangeCameraPositionState extends TripState {
  final LatLng latLng;

  const ChangeCameraPositionState({required this.latLng});

  @override
  List<Object> get props => [latLng];
}

class ChangeCameraPositionStartState extends TripState {
  final MainLocationData mainLocationData;

  const ChangeCameraPositionStartState({required this.mainLocationData});

  @override
  List<Object> get props => [mainLocationData];
}

class ConfirmPointState extends TripState {
  final int stateIndex;

  const ConfirmPointState({required this.stateIndex});

  @override
  List<Object> get props => [stateIndex];
}



class GetDriversSuccessState extends TripState {}
class GetDriversFailureState extends TripState {
  final String msg;

  const GetDriversFailureState({required this.msg});
}

class ClearMarkersState extends TripState {}

class LocationPermissionDeniedState extends TripState {}

class LocationServiceDisabledState extends TripState {}
