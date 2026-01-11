part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class PickLocationState extends LocationState {
  final LatLng latLng;

  const PickLocationState({required this.latLng});

  @override
  List<Object> get props => [latLng];
}

class GetLocationLoading extends LocationState {}

class GetLocationSuccess extends LocationState {
  final LatLng latLng;

  const GetLocationSuccess({required this.latLng});

  @override
  List<Object> get props => [latLng];
}

class GetLocationFailure extends LocationState {
  final String error;

  const GetLocationFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class LocationPermissionDenied extends LocationState {
  final bool isPermanentlyDenied;

  const LocationPermissionDenied({required this.isPermanentlyDenied});

  @override
  List<Object> get props => [isPermanentlyDenied];
}
