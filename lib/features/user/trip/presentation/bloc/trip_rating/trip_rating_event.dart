part of 'trip_rating_bloc.dart';

@immutable
sealed class TripRatingEvent {}

class SendTripRatingEvent extends TripRatingEvent {
  final ReviewTripParams tripParams;

  SendTripRatingEvent({required this.tripParams});
}
