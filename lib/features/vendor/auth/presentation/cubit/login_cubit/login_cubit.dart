import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/login_user_use_case.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase _loginUserUseCase;

  LoginCubit(this._loginUserUseCase) : super(LoginInitial());

  Future<void> sendOtp({
    required String phone,
  }) async {
    emit(SendOtpLoading());
    final response = await _loginUserUseCase(phone: phone);
    emit(response.fold((l) => SendOtpError(msg: l.msg),
        (r) => SendOtpSuccess(phoneNumber: phone)));
  }
}
