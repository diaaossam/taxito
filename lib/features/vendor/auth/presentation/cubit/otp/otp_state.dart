part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

class VerifyOtpLoadingState extends OtpState {}

class VerifyOtpSuccessState extends OtpState {
  final UserModel data;

  VerifyOtpSuccessState({required this.data});
}

class VerifyOtpFailureState extends OtpState {
  final String errorMsg;

  VerifyOtpFailureState({required this.errorMsg});
}

class ResendOtpLoadingState extends OtpState {}

class ResendOtpSuccessState extends OtpState {
  ResendOtpSuccessState();
}

class ResendOtpFailureState extends OtpState {
  final String errorMsg;

  ResendOtpFailureState({required this.errorMsg});
}
