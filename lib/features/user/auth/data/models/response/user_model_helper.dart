import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/features/user/presentation/bloc/user_bloc.dart';
import 'user_model.dart';

class UserDataService {
  static final UserDataService _instance = UserDataService._internal();
  UserModel? _user;

  factory UserDataService() {
    return _instance;
  }

  UserDataService._internal();

  void setUserData(UserModel user) {
    _user = user;
  }

  void clearUserData() {
    _user = null;
  }

  UserModel? getUserData() {
    return _user;
  }

  Future<void> reloadUserData({required BuildContext context}) async {
    final user = await context.read<UserBloc>().getUserData(userId: null);
    _user = user;
  }

  void updateUserData(UserModel updatedUser) {
    if (_user != null) {
      _user = updatedUser;
    }
  }
}
