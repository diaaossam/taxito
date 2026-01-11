part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

class UpdateUserDataLoading extends UpdateState {}

class UpdateUserDataSuccess extends UpdateState {
  final String msg;

  UpdateUserDataSuccess({required this.msg});
}

class UpdateUserDataFailure extends UpdateState {
  final String errorMsg;

  UpdateUserDataFailure({required this.errorMsg});
}

class DeleteUserDataLoading extends UpdateState {}

class DeleteUserDataSuccess extends UpdateState {
  final String msg;

  DeleteUserDataSuccess({required this.msg});
}

class DeleteUserDataFailure extends UpdateState {
  final String errorMsg;

  DeleteUserDataFailure({required this.errorMsg});
}