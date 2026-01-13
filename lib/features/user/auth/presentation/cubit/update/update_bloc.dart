import 'dart:io';
import 'package:taxito/features/common/models/register_params.dart';
import 'package:taxito/features/user/auth/domain/usecases/delete_account_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:taxito/features/user/auth/domain/usecases/update_user_data_use_case.dart';
import 'package:injectable/injectable.dart';

part 'update_event.dart';

part 'update_state.dart';

@Injectable()
class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  File? userImage;
  final UpdateUserDataUseCase updateUserDataUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  UpdateBloc(this.updateUserDataUseCase, this.deleteAccountUseCase)
      : super(UpdateInitial()) {
    on<UpdateUserDataEvent>(
      (event, emit) async {
        emit(UpdateUserDataLoading());
        final response = await updateUserDataUseCase(params: event.params);
        emit(response.fold(
          (l) => UpdateUserDataFailure(errorMsg: l.msg),
          (r) => UpdateUserDataSuccess(msg: r.message ?? ""),
        ));
      },
    );

    on<DeleteUserDataEvent>(
      (event, emit) async {
        emit(DeleteUserDataLoading());
        final response = await deleteAccountUseCase();
        emit(response.fold(
          (l) => DeleteUserDataFailure(errorMsg: l.msg),
          (r) => DeleteUserDataSuccess(msg: r.message ?? ""),
        ));
      },
    );
  }
}
