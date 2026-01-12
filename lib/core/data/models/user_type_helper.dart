import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/features/captain/user/presentation/bloc/user_bloc.dart';
import 'package:taxito/core/data/models/user_model.dart';

class UserTypeService {
  static final UserTypeService _instance = UserTypeService._internal();
  UserType? _user;

  factory UserTypeService() {
    return _instance;
  }

  UserTypeService._internal();

  void setUserType(UserType user) {
    _user = user;
  }

  void clearUserType() {
    _user = null;
  }

  UserType? getUserType() {
    return _user;
  }

  void updateUserType(UserType updatedUser) {
    if (_user != null) {
      _user = updatedUser;
    }
  }
}
