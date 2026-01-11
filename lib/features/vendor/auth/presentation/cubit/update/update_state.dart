part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

class UpdateUserDataLoading extends UpdateState {}

class UpdateUserDataSuccess extends UpdateState {
}

class UpdateUserDataFailure extends UpdateState {
  final String errorMsg;

  UpdateUserDataFailure({required this.errorMsg});
}