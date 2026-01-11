import 'package:taxito/features/captain/auth/domain/usecases/delete_account_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/register_params.dart';
import '../../../domain/usecases/register_user_use_case.dart';

part 'complete_register_event.dart';

part 'complete_register_state.dart';

@Injectable()
class CompleteRegisterBloc
    extends Bloc<CompleteRegisterEvent, CompleteRegisterState> {
  final RegisterUserUseCase registerUserUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  int currentStep = 0;
  RegisterParams registerParams = RegisterParams();

  CompleteRegisterBloc(this.registerUserUseCase, this.deleteAccountUseCase)
    : super(CompleteRegisterInitial()) {
    on<OnPageChangedEvent>((event, emit) {
      currentStep = event.index;
      emit(OnChangePageState());
    });
    on<UpdateRegisterParamsEvent>((event, emit) {
      registerParams = event.registerParams;
      currentStep = event.nextStep;
      emit(UpdateRegisterParams(nextStep: event.nextStep));
    });
    on<CompleteRegisterSuccessEvent>((event, emit) async {
      registerParams = event.registerParams;
      emit(RegisterUserLoading());
      final response = await registerUserUseCase(
        registerParams: event.registerParams,
      );
      emit(
        response.fold(
          (l) {
            return RegisterUserFailure(errorMsg: l.msg);
          },
          (r) {
            return RegisterUserSuccess();
          },
        ),
      );
    });

    on<DeleteAccountEvent>((event, emit) async {
      emit(DeleteUserLoading());
      final response = await deleteAccountUseCase(reason: 1);
      emit(
        response.fold(
          (l) => DeleteUserFailure(errorMsg: l.msg),
          (r) => DeleteUserSuccess(),
        ),
      );
    });
  }
}
