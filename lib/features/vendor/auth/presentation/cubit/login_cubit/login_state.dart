part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangePasswordVisibility extends LoginState {}

class SendOtpLoading extends LoginState {}

class SendOtpSuccess extends LoginState {
  final String phoneNumber;

  SendOtpSuccess({required this.phoneNumber});
}

class SendOtpError extends LoginState {
  final String msg;

  SendOtpError({required this.msg});
}
