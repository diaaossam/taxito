part of 'request_trip_info_bloc.dart';

@immutable
sealed class RequestTripState {}

final class RequestTripInfoInitial extends RequestTripState {}

final class MakeTripRequestLoading extends RequestTripState {}

final class MakeTripRequestSuccess extends RequestTripState {
  final TripModel tripModel;

  MakeTripRequestSuccess({required this.tripModel});
}

final class MakeTripRequestFailure extends RequestTripState {
  final String msg;

  MakeTripRequestFailure({required this.msg});
}


final class SearchingForDriverState extends RequestTripState {
  final TripModel tripModel;

  SearchingForDriverState({required this.tripModel});
}

final class DriverFoundState extends RequestTripState {
  final TripModel tripModel;

  DriverFoundState({required this.tripModel});
}

final class SearchTimeoutState extends RequestTripState {}

final class SearchCancelledState extends RequestTripState {}
