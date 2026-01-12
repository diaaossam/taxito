import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:taxito/core/data/models/register_params.dart';
import '../../../domain/usecases/register_user_use_case.dart';

part 'update_event.dart';

part 'update_state.dart';

@Injectable()
class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  File? userImage;
  final RegisterUserUseCase updateUserDataUseCase;

  UpdateBloc(this.updateUserDataUseCase) : super(UpdateInitial()) {
    on<UpdateUserEvent>(
      (event, emit) async {
        emit(UpdateUserDataLoading());
        final response =
            await updateUserDataUseCase(registerParams: event.registerParams);
        emit(response.fold(
          (l) => UpdateUserDataFailure(errorMsg: l.msg),
          (r) => UpdateUserDataSuccess(),
        ));
      },
    );
  }
}
