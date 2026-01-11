abstract class DriverLocationState {}

final class DriverLocationInitial extends DriverLocationState {}

final class GetCurrentDriverLocation extends DriverLocationState {}

final class DrawPolylineState extends DriverLocationState {}

final class OnGoogleMapControllerState extends DriverLocationState {}

class GetCurrentLocationLoadingState extends DriverLocationState {}

class GetCurrentLocationSuccessState extends DriverLocationState {}

class GetCurrentLocationFailureState extends DriverLocationState {
  final String errorMsg;

  GetCurrentLocationFailureState({required this.errorMsg});
}

class UpdateDriverLocationState extends DriverLocationState {
  final double lat;
  final double lon;

  UpdateDriverLocationState({required this.lat, required this.lon});
}
