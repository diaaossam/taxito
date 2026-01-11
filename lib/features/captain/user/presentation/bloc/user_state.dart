part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class GetUserSuccess extends UserState {
  final UserModel userModel;

  GetUserSuccess({required this.userModel});
}
