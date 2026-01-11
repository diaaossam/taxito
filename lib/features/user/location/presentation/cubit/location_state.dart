part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class GetSuggestMapLoading extends LocationState {}

class GetSuggestMapSuccess extends LocationState {
  final List<SuggestionModel> list;

  const GetSuggestMapSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class GetSuggestMapFailure extends LocationState {
  final String errorMsg;

  const GetSuggestMapFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

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

