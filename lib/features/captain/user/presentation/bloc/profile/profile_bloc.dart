import 'dart:async';
import 'package:taxito/core/data/models/user_model_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:taxito/core/data/models/user_model.dart';
import 'package:taxito/features/captain/auth/domain/usecases/get_user_data_use_case.dart';
import 'profile_state.dart';

part 'profile_event.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserDataUseCase getUserDataUseCase;
  UserModel? userModel;

  ProfileBloc(
    this.getUserDataUseCase,
  ) : super(ProfileInitial()) {
    on<GetUserDataEvent>(_getUserData);
  }

  FutureOr<void> _getUserData(
      GetUserDataEvent event, Emitter<ProfileState> emit) async {
    emit(GetUserDataLoading());
    if (event.userId == null) {
      userModel = UserDataService().getUserData();
      emit(GetUserDataSuccess(userModel: userModel!));
    } else {
      final response = await getUserDataUseCase();
      emit(response.fold((l) {
        return GetUserDataFailure(errorMsg: l.msg);
      }, (r) {
        userModel = r.data;
        return GetUserDataSuccess(userModel: userModel!);
      }));
    }
  }
}
