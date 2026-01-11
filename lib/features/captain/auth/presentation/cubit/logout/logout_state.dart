part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}

class LogoutUserLoading extends LogoutState {}

class LogoutUserSuccess extends LogoutState {
  final String msg;

  LogoutUserSuccess({required this.msg});
}

class LogoutUserError extends LogoutState {
  final String msg;

  LogoutUserError({required this.msg});
}
