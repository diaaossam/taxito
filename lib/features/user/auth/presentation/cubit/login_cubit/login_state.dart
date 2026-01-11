part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangePasswordVisibility extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String phoneNumber;
  final UserType userType;

  LoginSuccess({required this.phoneNumber, required this.userType});
}

class LoginError extends LoginState {
  final String msg;

  LoginError({required this.msg});
}
