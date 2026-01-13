import 'package:taxito/core/services/socket/socket.dart';
import 'package:taxito/features/captain/driver_trip/domain/usecases/get_trip_by_id_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../common/models/trip_model.dart';

part 'trip_state.dart';

@Injectable()
class TripCubit extends Cubit<TripState> {
  TripCubit(this.getTripByIdUseCase, this.socketService) : super(TripInitial());

  final GetTripByIdUseCase getTripByIdUseCase;
  final SocketService socketService;
  TripModel? tripModel;
  Map<String, dynamic> tripMap = {};

  void updateTripModel({TripModel? model}) {
    tripModel = model;
    emit(UpdateTripModelState(tripModel: model));
  }

  Future<void> getTripModelByUuid({required num id}) async {
    emit(GetTripByIdLoading());
    final response = await getTripByIdUseCase(id: id);
    emit(
      response.fold((l) => GetTripByIdFailure(errorMsg: l.msg), (r) {
        tripModel = r.data;
        tripMap = r.response ?? {};
        return GetTripByIdSuccess(tripModel: r.data);
      }),
    );
  }
}
