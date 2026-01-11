part of 'track_order_cubit.dart';

@immutable
sealed class TrackOrderState {}

final class TrackOrderInitial extends TrackOrderState {}

final class GetOrderDetailsLoading extends TrackOrderState {}

final class GetOrderDetailsSuccess extends TrackOrderState {
  final Orders orders;

  GetOrderDetailsSuccess({required this.orders});
}

final class GetOrderDetailsFailure extends TrackOrderState {
  final String msg;

  GetOrderDetailsFailure({required this.msg});
}

final class DeleteOrderLoading extends TrackOrderState {
  final num id;

  DeleteOrderLoading({required this.id});
}

final class DeleteOrderSuccess extends TrackOrderState {
  final String msg;
  final num id;

  DeleteOrderSuccess({required this.msg, required this.id});
}

final class DeleteOrderFailure extends TrackOrderState {
  final String msg;

  DeleteOrderFailure({required this.msg});
}
