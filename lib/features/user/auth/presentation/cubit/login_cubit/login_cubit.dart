import 'package:aslol/core/enum/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/features/auth/domain/usecases/login_user_use_case.dart';

import '../../../data/models/request/login_params.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase _loginUserUseCase;

  LoginCubit(this._loginUserUseCase) : super(LoginInitial());

  Future<void> login({required LoginParams params}) async {
    emit(LoginLoading());
    final response = await _loginUserUseCase(params: params);
    emit(response.fold(
        (l) => LoginError(msg: l.msg),
        (r) => LoginSuccess(
            phoneNumber: params.phone, userType: params.userType)));
  }
}
