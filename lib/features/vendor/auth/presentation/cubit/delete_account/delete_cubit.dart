import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/delete_account_use_case.dart';

part 'delete_state.dart';

@Injectable()
class DeleteCubit extends Cubit<DeleteState> {
  final DeleteAccountUseCase deleteAccountUseCase;

  DeleteCubit(this.deleteAccountUseCase) : super(DeleteInitial());

  Future<void> deleteAccount() async {
    emit(DeleteUserLoading());
    final response = await deleteAccountUseCase(reason: 1);
    emit(response.fold(
      (l) => DeleteUserFailure(msg: l.msg),
      (r) => DeleteUserSuccess(),
    ));
  }
}
