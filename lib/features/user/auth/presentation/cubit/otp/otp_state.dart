part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

class VerifyOtpLoadingState extends OtpState {}

class VerifyOtpSuccessState extends OtpState {
  final UserModel userModel;

  VerifyOtpSuccessState({required this.userModel});
}

class VerifyOtpFailureState extends OtpState {
  final String errorMsg;

  VerifyOtpFailureState({required this.errorMsg});
}
