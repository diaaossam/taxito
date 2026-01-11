part of 'rating_cubit.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}
final class GetProductReviewLoading extends RatingState {}
final class GetProductReviewSuccess extends RatingState {}
final class GetProductReviewFailure extends RatingState {
  final String msg;

  GetProductReviewFailure({required this.msg});
}
