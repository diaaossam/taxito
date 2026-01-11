import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/features/settings/data/models/settings_model.dart';
import 'package:aslol/features/settings/domain/usecases/get_app_settings_use_case.dart';

part 'settings_event.dart';

part 'settings_state.dart';

@Injectable()
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetAppSettingsUseCase getAppSettingsUseCase;

  SettingsModel? settingsModel;

  SettingsBloc(this.getAppSettingsUseCase) : super(SettingsInitial()) {
    on<GetAppSettingsEvent>((event, emit) async {
      emit(GetAppSettingsLoading());
      final response = await getAppSettingsUseCase();
      emit(response.fold((l) => GetAppSettingsFailure(errorMsg: l.msg), (r) {
        settingsModel = r.data;
        return GetAppSettingsSuccess(settingsModel: r.data);
      }));
    });
  }
}
