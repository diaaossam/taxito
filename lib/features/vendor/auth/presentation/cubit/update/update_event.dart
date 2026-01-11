part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class UpdateUserEvent extends UpdateEvent {
  final RegisterParams registerParams;

  UpdateUserEvent({required this.registerParams});
}
