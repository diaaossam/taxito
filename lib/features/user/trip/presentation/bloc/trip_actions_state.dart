part of 'trip_actions_cubit.dart';

@immutable
sealed class TripActionsState {}

final class TripActionsInitial extends TripActionsState {}
final class CancelTripLoading extends TripActionsState {}
final class CancelTripSuccess extends TripActionsState {

}
final class CancelTripFailure extends TripActionsState {
  final String errorMsg;

  CancelTripFailure({required this.errorMsg});
}
