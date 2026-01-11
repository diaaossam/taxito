import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/captain/start/domain/usecases/init_app_use_case.dart';
import 'package:taxito/features/captain/start/presentation/cubit/start/start_state.dart';

@Injectable()
class StartCubit extends Cubit<StartState> {
  final InitAppUseCase initAppUseCase;

  StartCubit(this.initAppUseCase) : super(StartInitial());

  Future<void> initApp() async {
    emit(InitAppLoading());
    final response = await initAppUseCase();
    emit(
      response.fold(
        (l) => InitAppError(errorMsg: l.msg),
        (r) => InitAppSuccess(widget: r.data),
      ),
    );
  }
}
