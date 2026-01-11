part of 'complete_register_bloc.dart';

@immutable
sealed class CompleteRegisterState {}

final class CompleteRegisterInitial extends CompleteRegisterState {}

final class OnChangePageState extends CompleteRegisterState {}

final class UpdateRegisterParams extends CompleteRegisterState {
  final int nextStep;

  UpdateRegisterParams({required this.nextStep});
}

class RegisterUserLoading extends CompleteRegisterState {}

class RegisterUserFailure extends CompleteRegisterState {
  final String errorMsg;

  RegisterUserFailure({required this.errorMsg});
}

class RegisterUserSuccess extends CompleteRegisterState {
  RegisterUserSuccess();
}

class DeleteUserLoading extends CompleteRegisterState {}

class DeleteUserFailure extends CompleteRegisterState {
  final String errorMsg;

  DeleteUserFailure({required this.errorMsg});
}

class DeleteUserSuccess extends CompleteRegisterState {
  DeleteUserSuccess();
}
