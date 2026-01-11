part of 'accepted_user_trip_cubit.dart';

@immutable
sealed class AcceptedUserTripState {}

final class AcceptedUserTripInitial extends AcceptedUserTripState {}
final class UpdateTripStatesState extends AcceptedUserTripState {
  final bool isCancel;

  UpdateTripStatesState({required this.isCancel});
}

final class ListenToUserLocation extends AcceptedUserTripState {
  final double driverLat;
  final double driverLng;

  ListenToUserLocation({required this.driverLat, required this.driverLng});
}
final class UserJoinedToTripRoomState extends AcceptedUserTripState {}
final class AcceptedUserTripError extends AcceptedUserTripState {
  final String message;

  AcceptedUserTripError({required this.message});
}



final class UpdateTripLoadingState extends AcceptedUserTripState {}
final class UpdateTripSuccessState extends AcceptedUserTripState {
  final TripModel tripModel;

  UpdateTripSuccessState({required this.tripModel});
}
final class UpdateTripFailureState extends AcceptedUserTripState {
  final String msg;

  UpdateTripFailureState({required this.msg});
}
