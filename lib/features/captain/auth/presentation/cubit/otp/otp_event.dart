part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class VerifyOtpCodeEvent extends OtpEvent {
  final String phone;
  final String otpCode;
  final UserType userType;

  VerifyOtpCodeEvent({
    required this.phone,
    required this.otpCode,
    required this.userType,
  });
}

class ResendOtpCodeEvent extends OtpEvent {
  final String phone;
  final UserType userType;

  ResendOtpCodeEvent({required this.phone, required this.userType});
}
