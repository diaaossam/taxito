part of 'complete_register_bloc.dart';

@immutable
sealed class CompleteRegisterState {}

final class CompleteRegisterInitial extends CompleteRegisterState {}
final class GetSupplierCategoriesState extends CompleteRegisterState {}

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