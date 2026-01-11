part of 'delete_cubit.dart';

@immutable
sealed class DeleteState {}

final class DeleteInitial extends DeleteState {}
final class DeleteUserLoading extends DeleteState {}
final class DeleteUserFailure extends DeleteState {
  final String msg;

  DeleteUserFailure({required this.msg});
}
final class DeleteUserSuccess extends DeleteState {}
