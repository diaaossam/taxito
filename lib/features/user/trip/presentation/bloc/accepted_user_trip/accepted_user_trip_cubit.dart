import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/data/models/trip_model.dart';
import '../../../../../../core/enum/trip_status_enum.dart';
import '../../../../../../core/services/socket/socket.dart';
import '../../../domain/usecases/get_trip_by_id_use_case.dart';

part 'accepted_user_trip_state.dart';

@Injectable()
class AcceptedUserTripCubit extends Cubit<AcceptedUserTripState> {
  final SocketService socketService;
  final GetTripByIdUseCase getTripByIdUseCase;
  String tripIdValue = "";
  TripModel? tripModel;

  AcceptedUserTripCubit(this.socketService, this.getTripByIdUseCase)
    : super(AcceptedUserTripInitial());

  Future<void> joinUserToTripRoom({required TripModel model}) async {
    if (!socketService.isConnected()) {
      await socketService.ensureAuthorizedConnected();
    }
    if (!socketService.isConnected()) {
      emit(AcceptedUserTripError(message: 'Unable to connect to server'));
      return;
    }

    socketService.emitEvent("addUserToTrip", {"tripId": model.uuid});

    socketService.onEvent("updating-trip.${model.uuid}", (event) {
      if (isClosed) return;
      double driverLat = event?['driverLat'];
      double driverLng = event?['driverLng'];
      emit(ListenToUserLocation(driverLat: driverLat, driverLng: driverLng));
    });
    socketService.onEvent("update-trip-status.${model.uuid}", (event) async {
      if (isClosed) return;
      TripStatusEnum? status = handleStringToTripStatusEnum(
        data: event['status'],
      );
      tripModel = tripModel?.copyWith(status: status);
      emit(UpdateTripStatesState(isCancel: status == TripStatusEnum.cancelled));
    });
    tripIdValue = model.uuid.toString();
    if (!isClosed) {
      tripModel = model;
      emit(UserJoinedToTripRoomState());
    }
  }

  Future<void> getTripByUuid({required num id}) async {
    if (isClosed) return;
    emit(UpdateTripLoadingState());
    final response = await getTripByIdUseCase(id: id);
    if (isClosed) return;
    emit(
      response.fold((l) => UpdateTripFailureState(msg: l.msg), (r) {
        tripModel = r.data;
        return UpdateTripSuccessState(tripModel: r.data);
      }),
    );
  }

  void resetCubit() {
    if (tripIdValue.isNotEmpty) {
      socketService.disconnectFromRoom("updating-trip.$tripIdValue");
      socketService.disconnectFromRoom("update-trip-status.$tripIdValue");
    }

    // Reset internal state
    tripIdValue = "";

    // Reset to initial state
    if (!isClosed) {
      emit(AcceptedUserTripInitial());
    }
  }

  @override
  Future<void> close() {
    socketService.disconnectFromRoom("updating-trip.$tripIdValue");
    socketService.disconnectFromRoom("addUserToTrip");
    socketService.disconnectFromRoom("update-trip-status.$tripIdValue");
    return super.close();
  }
}
