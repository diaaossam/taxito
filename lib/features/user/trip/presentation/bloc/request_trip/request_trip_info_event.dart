part of 'request_trip_info_bloc.dart';

@immutable
sealed class RequestTripEvent {}

class MakeTripRequestEvent extends RequestTripEvent {
  final TripParams tripParams;

  MakeTripRequestEvent({required this.tripParams});
}

class StartSearchingForDriverEvent extends RequestTripEvent {
  final TripModel tripModel;

  StartSearchingForDriverEvent({required this.tripModel});
}

class DriverFoundEvent extends RequestTripEvent {
  final TripModel tripModel;

  DriverFoundEvent({required this.tripModel});
}

class SearchTimeoutEvent extends RequestTripEvent {}

class CancelSearchEvent extends RequestTripEvent {}
