part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class GetPlaceDetailsByPlaceIdLoading extends LocationState {}

class GetPlaceDetailsByPlaceIdSuccess extends LocationState {
  final MainLocationData location;

  const GetPlaceDetailsByPlaceIdSuccess({required this.location});

  @override
  List<Object> get props => [location];
}

class GetPlaceDetailsByPlaceIdFailure extends LocationState {
  final String errorMsg;

  const GetPlaceDetailsByPlaceIdFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}


class GetSavedLocationLoading extends LocationState {}

class GetSavedLocationFailure extends LocationState {
  final String error;

  const GetSavedLocationFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class GetSavedLocationSuccess extends LocationState {
  final List<SavedLocationModel> list;

  const GetSavedLocationSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

