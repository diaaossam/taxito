import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../app/data/models/generic_model.dart';
import '../../../domain/usecases/get_governorates_use_case.dart';

part 'governorate_event.dart';

part 'governorate_state.dart';

@Injectable()
class GovernorateBloc extends Bloc<GovernorateEvent, GovernorateState> {
  final GetGovernoratesUseCase getGovernoratesUseCase;

  GovernorateBloc(this.getGovernoratesUseCase) : super(GovernorateInitial()) {
    on<GetAllGovernorateEvent>((event, emit) async {
      emit(GetAllGovernorateLoading());
      final response = await getGovernoratesUseCase();
      emit(response.fold(
        (l) => GetAllGovernorateFailure(),
        (r) => GetAllGovernorateSuccess(list: r.data),
      ));
    });
  }
}
