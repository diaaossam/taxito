part of 'accepted_driver_cubit.dart';

@immutable
sealed class AcceptedDriverState {}

final class AcceptedDriverInitial extends AcceptedDriverState {}

final class ListenToTripPaymentCashState extends AcceptedDriverState {}

final class UpdateTripLoading extends AcceptedDriverState {}

final class UpdateTripSuccess extends AcceptedDriverState {
  final bool isCancel;
  final bool isDelivered;
  final TripModel tripModel;

  UpdateTripSuccess(
      {required this.tripModel,
      required this.isCancel,
      required this.isDelivered});
}

final class UpdateTripFailed extends AcceptedDriverState {
  final String msg;

  UpdateTripFailed({required this.msg});
}

final class GetTripByIdLoading extends AcceptedDriverState {}

final class GetTripByIdSuccess extends AcceptedDriverState {
  final TripModel tripModel;

  GetTripByIdSuccess({required this.tripModel});
}

final class GetTripByIdFailure extends AcceptedDriverState {
  final String errorMsg;

  GetTripByIdFailure({required this.errorMsg});
}

final class AcceptPaymentRequestLoading extends AcceptedDriverState {}

final class AcceptPaymentRequestSuccess extends AcceptedDriverState {}

final class AcceptPaymentRequestFailure extends AcceptedDriverState {
  final String msg;

  AcceptPaymentRequestFailure({required this.msg});
}
