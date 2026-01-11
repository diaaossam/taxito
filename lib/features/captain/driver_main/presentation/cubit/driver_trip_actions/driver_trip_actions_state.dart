part of 'driver_trip_actions_cubit.dart';

@immutable
sealed class DriverTripActionsState {}

final class GetCurrentLocationState extends DriverTripActionsState {}
final class DriverTripActionsInitial extends DriverTripActionsState {}

final class AcceptTripLoading extends DriverTripActionsState {}

final class AcceptTripFailure extends DriverTripActionsState {
  final String error;

  AcceptTripFailure({required this.error});
}

final class AcceptTripSuccess extends DriverTripActionsState {
  final TripModel tripModel;
  final Map<String, dynamic> map;

  AcceptTripSuccess({required this.tripModel, required this.map});
}

final class RejectTripRequestLoadingState extends DriverTripActionsState {}

final class RejectTripRequestSuccessState extends DriverTripActionsState {}

final class UserCanceledTripState extends DriverTripActionsState {}
