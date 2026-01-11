part of 'searching_for_driver_bloc.dart';

@immutable
sealed class SearchingForDriverState {}

final class SearchingForDriverInitial extends SearchingForDriverState {}

final class SocketConnecting extends SearchingForDriverState {}
final class SocketError extends SearchingForDriverState {
  final String errorMessage;

  SocketError({required this.errorMessage});
}

final class CancelTripLoading extends SearchingForDriverState {}
final class CancelTripSuccess extends SearchingForDriverState {}
final class CancelTripFailure extends SearchingForDriverState {
  final String errorMsg;

  CancelTripFailure({required this.errorMsg});
}

final class DriverFound extends SearchingForDriverState {
  final TripModel tripModel;

  DriverFound({required this.tripModel});
}


final class SearchForDriverLoading extends SearchingForDriverState {}
final class SearchForDriverSuccess extends SearchingForDriverState {}
final class SearchForDriverFailure extends SearchingForDriverState {
  final String msg;

  SearchForDriverFailure({required this.msg});
}
