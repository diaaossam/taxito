import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/log_out_use_case.dart';

part 'logout_state.dart';

@Injectable()
class LogoutCubit extends Cubit<LogoutState> {
  final LogOutUseCase logOutUseCase;

  LogoutCubit(this.logOutUseCase) : super(LogoutInitial());

  Future<void> logoutAccount() async {
    emit(LogoutUserLoading());
    final response = await logOutUseCase();
    emit(response.fold((l) => LogoutUserError(msg: l.msg),
        (r) => LogoutUserSuccess(msg: r.message ?? "")));
  }
}
