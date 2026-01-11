part of 'driver_home_cubit.dart';

@immutable
sealed class DriverHomeState {}

final class DriverHomeInitial extends DriverHomeState {}

final class UpdateDriverLocation extends DriverHomeState {
  final double lat;
  final double lon;

  UpdateDriverLocation({required this.lat, required this.lon});
}

final class InitTripState extends DriverHomeState {
  final TripModel? tripModel;
  final int second;

  InitTripState({required this.tripModel, required this.second});
}

final class ChangeExpandedBottomNavState extends DriverHomeState {}

final class ReceiveTripRequestState extends DriverHomeState {
  final TripModel tripModel;
  final LatLng? currentLocation;

  ReceiveTripRequestState({required this.tripModel, this.currentLocation});
}

final class UpdateTripModelState extends DriverHomeState {
  final TripModel? tripModel;

  UpdateTripModelState({this.tripModel});
}

final class GetTripByUuidLoading extends DriverHomeState {}

final class GetTripByUuidSuccess extends DriverHomeState {
  final TripModel tripModel;

  GetTripByUuidSuccess({required this.tripModel});
}

final class GetTripByUuidFailure extends DriverHomeState {
  final String errorMsg;

  GetTripByUuidFailure({required this.errorMsg});
}

final class AcceptTripLoading extends DriverHomeState {}

final class AcceptTripFailure extends DriverHomeState {
  final String error;

  AcceptTripFailure({required this.error});
}

final class AcceptTripSuccess extends DriverHomeState {
  final TripModel tripModel;

  AcceptTripSuccess({required this.tripModel});
}

class GetTripByUUidLoading extends DriverHomeState {}

class GetTripByUUidFailure extends DriverHomeState {}

class GetTripByUUidSuccess extends DriverHomeState {
  final TripModel tripModel;

  GetTripByUUidSuccess({required this.tripModel});
}

class GetBalanceLoading extends DriverHomeState {}

class GetBalanceFailure extends DriverHomeState {}

class GetBalanceSuccess extends DriverHomeState {}
