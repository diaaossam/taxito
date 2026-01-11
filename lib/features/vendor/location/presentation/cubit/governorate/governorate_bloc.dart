import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../captain/app/data/models/generic_model.dart';
import '../../../domain/usecases/get_governorates_use_case.dart';
import '../../../domain/usecases/get_region_use_case.dart';

part 'governorate_event.dart';

part 'governorate_state.dart';

@Injectable()
class GovernorateBloc extends Bloc<GovernorateEvent, GovernorateState> {
  final GetGovernoratesUseCase getGovernoratesUseCase;
  final GetRegionUseCase getRegionUseCase;

  List<GenericModel> governorate = [];
  List<GenericModel> region = [];

  GovernorateBloc(this.getGovernoratesUseCase, this.getRegionUseCase)
    : super(GovernorateInitial()) {
    on<GetAllGovernorateEvent>((event, emit) async {
      emit(GetAllGovernorateLoading());
      final response = await getGovernoratesUseCase();
      emit(
        response.fold((l) => GetAllGovernorateFailure(), (r) {
          governorate = r.data;
          return GetAllGovernorateSuccess(list: r.data);
        }),
      );
    });
    on<GetAllRegionEvent>((event, emit) async {
      emit(GetAllRegionLoading());
      final response = await getRegionUseCase(id: event.id);
      emit(
        response.fold((l) => GetAllRegionFailure(), (r) {
          region = r.data;
          return GetAllRegionSuccess(list: r.data);
        }),
      );
    });
  }
}
