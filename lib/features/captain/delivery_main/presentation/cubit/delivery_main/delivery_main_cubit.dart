import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../auth/domain/usecases/update_fcm_use_case.dart';
part 'delivery_main_state.dart';

@Injectable()
class DeliveryMainCubit extends Cubit<DeliveryMainState> {
  final UpdateFcmUseCase _updateFcmUseCase;
  int currentIndex = 0;
  int currentBalance = 0;

  DeliveryMainCubit(
    this._updateFcmUseCase,
  ) : super(HomeInitial()) {
    _updateFcmUseCase();
  }

  void changeBottomNavIndex({required int index}) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }
}
