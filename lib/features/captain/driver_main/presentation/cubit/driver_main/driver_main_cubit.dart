import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../auth/domain/usecases/update_fcm_use_case.dart';
import '../../../../driver_trip/data/models/trip_model.dart';

part 'driver_main_state.dart';

@Injectable()
class DriverMainCubit extends Cubit<DriverMainState> {
  final UpdateFcmUseCase _updateFcmUseCase;
  int currentIndex = 0;
  int currentBalance = 0;

  DriverMainCubit(
    this._updateFcmUseCase,
  ) : super(HomeInitial()) {
    _updateFcmUseCase();
  }

  void changeBottomNavIndex({required int index}) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }
}
