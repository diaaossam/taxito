part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class ToggleFavouriteLoading extends FavouriteState {}
final class ToggleFavouriteSuccess extends FavouriteState {
  final String msg;

  ToggleFavouriteSuccess({required this.msg});
}
final class ToggleFavouriteFailure extends FavouriteState {
  final String msg;

  ToggleFavouriteFailure({required this.msg});
}
