import 'package:flutter/material.dart';
import 'package:taxito/features/captain/auth/data/models/response/user_model.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class GetUserDataLoading extends ProfileState {}

class GetUserDataSuccess extends ProfileState {
  final UserModel userModel;

  GetUserDataSuccess({required this.userModel});
}

class GetUserDataFailure extends ProfileState {
  final String errorMsg;

  GetUserDataFailure({required this.errorMsg});
}

class BlockUserStateLoading extends ProfileState {}

class BlockUserStateSuccess extends ProfileState {
  final String msg;

  BlockUserStateSuccess({required this.msg});
}

class BlockUserStateFailure extends ProfileState {
  final String errorMsg;

  BlockUserStateFailure({required this.errorMsg});
}

