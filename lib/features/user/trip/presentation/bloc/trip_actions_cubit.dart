import 'package:aslol/features/trip/domain/usecases/cancel_trip_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'trip_actions_state.dart';

@Injectable()
class TripActionsCubit extends Cubit<TripActionsState> {
  final CancelTripUseCase cancelTripUseCase;

  TripActionsCubit(this.cancelTripUseCase) : super(TripActionsInitial());

  Future<void> cancelTrip({required num id}) async {
    emit(CancelTripLoading());
    final response = await cancelTripUseCase(id: id,);
    emit(response.fold(
          (l) => CancelTripFailure(errorMsg: l.msg),
          (r) => CancelTripSuccess(),
    ));
  }
}
