import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/register_params.dart';

part 'complete_register_event.dart';

part 'complete_register_state.dart';

@Injectable()
class CompleteRegisterBloc
    extends Bloc<CompleteRegisterEvent, CompleteRegisterState> {
  final RegisterUserUseCase registerUserUseCase;
  final GetSupplierCategoryUseCase getSupplierCategoryUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  List<GenericModel> list = [];

  CompleteRegisterBloc(
    this.registerUserUseCase,
    this.getSupplierCategoryUseCase,
    this.deleteAccountUseCase,
  ) : super(CompleteRegisterInitial()) {
    on<GetSupplierCategoryEvent>((event, emit) async {
      final response = await getSupplierCategoryUseCase();
      response.fold((l) {}, (r) {
        list = r.data;
        emit(GetSupplierCategoriesState());
      });
    });
    on<UpdateRegisterParamsEvent>((event, emit) async {
      emit(RegisterUserLoading());
      final response = await registerUserUseCase(
        registerParams: event.registerParams,
      );
      emit(
        response.fold((l) => RegisterUserFailure(errorMsg: l.msg), (r) {
          return RegisterUserSuccess();
        }),
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
