import 'package:taxito/features/captain/delivery_order/data/models/response/statics_model.dart';
import 'package:taxito/features/captain/delivery_order/domain/usecases/get_statics_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'statics_state.dart';

@Injectable()
class StaticsCubit extends Cubit<StaticsState> {
  final GetStaticsUseCase getStaticsUseCase;

  StaticsCubit(this.getStaticsUseCase) : super(StaticsInitial()) {
    getAllStatics();
  }

  StaticsModel? staticsModel;

  Future<void> getAllStatics() async {
    emit(GetStaticsLoading());
    final response = await getStaticsUseCase();
    emit(response.fold(
      (l) => GetStaticsFailure(msg: l.msg),
      (r) {
        staticsModel = r.data;
        return GetStaticsSuccess();
      },
    ));
  }
}
