part of 'trip_rating_bloc.dart';

@immutable
sealed class TripRatingState {}

final class TripRatingInitial extends TripRatingState {}
final class SendTripRatingLoading extends TripRatingState {}
final class SendTripRatingSuccess extends TripRatingState {
  final String msg;

  SendTripRatingSuccess({required this.msg});
}
final class SendTripRatingFailure extends TripRatingState {
  final String message;

  SendTripRatingFailure({required this.message});
}
