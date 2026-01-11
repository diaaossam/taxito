part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}
class UpdateUserDataEvent extends UpdateEvent {
  final RegisterParams params;

  UpdateUserDataEvent({required this.params});
}
class DeleteUserDataEvent extends UpdateEvent {

}

