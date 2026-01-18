part of 'live_map_tracking_cubit.dart';

@immutable
sealed class LiveMapTrackingState {}

final class LiveMapTrackingInitial extends LiveMapTrackingState {}

final class TrackingStarted extends LiveMapTrackingState {}

final class DriverLocationUpdated extends LiveMapTrackingState {
  final LatLng location;

  DriverLocationUpdated({required this.location});
}

final class DriverLocationAnimating extends LiveMapTrackingState {
  final LatLng location;

  DriverLocationAnimating({required this.location});
}

final class MarkersUpdated extends LiveMapTrackingState {
  final Set<Marker> markers;

  MarkersUpdated({required this.markers});
}
