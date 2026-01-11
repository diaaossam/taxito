part of 'payment_confirmation_cubit.dart';

@immutable
sealed class PaymentConfirmationState {}

final class PaymentConfirmationInitial extends PaymentConfirmationState {}

final class ListenToPaymentRequestState extends PaymentConfirmationState {}


final class AcceptPaymentRequestLoading extends PaymentConfirmationState {}
final class AcceptPaymentRequestSuccess extends PaymentConfirmationState {}
final class AcceptPaymentRequestFailure extends PaymentConfirmationState {
  final String msg;

  AcceptPaymentRequestFailure({required this.msg});
}
