part of 'trip_payment_user_cubit.dart';

@immutable
sealed class TripPaymentUserState {}

final class TripPaymentUserInitial extends TripPaymentUserState {}
final class DriverSendConfirmPaymentState extends TripPaymentUserState {}
final class SendPaymentRequestLoading extends TripPaymentUserState {}
final class SendPaymentRequestSuccess extends TripPaymentUserState {}
final class SendPaymentRequestFailure extends TripPaymentUserState {
  final String msg;

  SendPaymentRequestFailure({required this.msg});
}
