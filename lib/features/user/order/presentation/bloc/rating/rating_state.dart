part of 'rating_cubit.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}
class SubmitRatingLoading extends RatingState {}
class SubmitRatingSuccess extends RatingState {
  final String msg;

  SubmitRatingSuccess({required this.msg});
}
class SubmitRatingFailure extends RatingState {
  final String msg;

  SubmitRatingFailure({required this.msg});
}
