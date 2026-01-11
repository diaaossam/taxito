part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class VerifyOtpCodeEvent extends OtpEvent {
  final String phone;
  final String otpCode;

  VerifyOtpCodeEvent({required this.phone, required this.otpCode});
}

class ResendOtpCodeEvent extends OtpEvent {
  final String phone;
  final UserType userType;

  ResendOtpCodeEvent({required this.phone, required this.userType});
}
