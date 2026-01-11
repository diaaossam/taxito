import 'package:aslol/features/app/data/models/generic_model.dart';
import 'package:aslol/features/location/domain/usecases/get_governorates_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/get_regions_use_case.dart';

part 'global_location_state.dart';

@Injectable()
class GlobalLocationCubit extends Cubit<GlobalLocationState> {
  final GetGovernoratesUseCase _getGovernoratesUseCase;
  final GetRegionUseCase getRegionUseCase;
  List<GenericModel> governorates = [];
  List<GenericModel> region = [];

  GlobalLocationCubit(this._getGovernoratesUseCase, this.getRegionUseCase)
      : super(const GlobalLocationState()) {
    fetchGovernorates();
  }

  Future<void> fetchGovernorates() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getGovernoratesUseCase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.msg)),
      (data) {
        governorates = data.data;
        emit(state.copyWith(isLoading: false, location: data.data));
      },
    );
  }

  Future<void> fetchRegion({required num id}) async {
    emit(state.copyWith(isLoading: true));
    final result = await getRegionUseCase(id: id);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.msg)),
      (data) {
        region = data.data;
        emit(state.copyWith(isLoading: false, location: data.data));
      },
    );
  }
}
