import 'dart:async';
import 'package:taxito/core/services/location/location_permission_service.dart';
import 'package:taxito/core/services/socket/socket.dart';
import 'package:taxito/features/captain/driver_trip/data/models/trip_model.dart';
import 'package:taxito/features/captain/driver_trip/domain/usecases/accept_trip_use_case.dart';
import 'package:taxito/features/captain/driver_trip/domain/usecases/reject_trip_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/data/models/user_model_helper.dart';

part 'driver_trip_actions_state.dart';

@Injectable()
class DriverTripActionsCubit extends Cubit<DriverTripActionsState> {
  final AcceptTripUseCase acceptTripUseCase;
  final RejectTripUseCase rejectTripUseCase;
  final SocketService socketService;

  DriverTripActionsCubit(
    this.acceptTripUseCase,
    this.socketService,
    this.rejectTripUseCase,
  ) : super(DriverTripActionsInitial()) {
    listenToActions();
  }

  LatLng? currentLocation;

  Future<void> listenToActions() async {
    final data = await LocationPermissionService().requestPermissionAndLocation();
    currentLocation = data.location;
    emit(GetCurrentLocationState());
    socketService.onEvent("trip-canceled", (p0) {
      if (!isClosed) {
        emit(UserCanceledTripState());
      }
    });
  }

  Future<void> acceptTrip({required TripModel tripModel}) async {
    if (isClosed) return;
    emit(AcceptTripLoading());
    final response = await acceptTripUseCase(tripId: tripModel.id ?? 0);
    if (isClosed) return;
    emit(
      response.fold((l) => AcceptTripFailure(error: l.msg), (r) {
        socketService.emitEvent("accept-trip", {"tripId": tripModel.uuid});
        socketService.emitEvent("update-status", {
          "driverId": UserDataService().getUserData()?.id,
          "isOnline": true,
          "hasTrip": true,
          "driverType": "order",
          "location": {"lat": 0, "lng": 0},
        });

        return AcceptTripSuccess(tripModel: r.data, map: r.response ?? {});
      }),
    );
  }

  /*  Future<void> rejectTrip({
    required TripModel tripModel,
  }) async {
    if (isClosed) return;
    emit(RejectTripRequestLoadingState());
    socketService.emitEvent("reject-trip", {"tripId": tripModel.uuid});
    if (isClosed) return;
    emit(RejectTripRequestSuccessState());
  }*/

  Future<void> rejectTrip({required TripModel tripModel}) async {
    if (isClosed) return;
    emit(RejectTripRequestLoadingState());
    final response = await rejectTripUseCase(tripId: tripModel.id ?? 0);
    if (isClosed) return;
    emit(
      response.fold((l) => AcceptTripFailure(error: l.msg), (r) {
        return RejectTripRequestSuccessState();
      }),
    );
    if (isClosed) return;
  }

  void resetCubit() {
    if (!isClosed) {
      emit(DriverTripActionsInitial());
    }
  }

  @override
  Future<void> close() {
    // Note: Not disconnecting from "trip-cancelled" as it's a shared event
    // The isClosed check in the listener prevents emitting after disposal
    return super.close();
  }
}
