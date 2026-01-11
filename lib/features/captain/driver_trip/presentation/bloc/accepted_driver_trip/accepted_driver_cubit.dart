import 'dart:async';
import 'package:taxito/core/enum/payment_type.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/enum/trip_status_enum.dart';
import '../../../../../../core/services/socket/socket.dart';
import '../../../../location/domain/usecases/update_driver_location_use_case.dart';
import '../../../data/models/trip_model.dart';
import '../../../domain/usecases/accept_driver_payment_request_use_case.dart';
import '../../../domain/usecases/cancel_trip_use_case.dart';
import '../../../domain/usecases/end_trip_use_case.dart';
import 'package:geolocator/geolocator.dart' as geo;

import '../../../domain/usecases/get_trip_by_id_use_case.dart';
import '../../../domain/usecases/update_trip_status_use_case.dart';

part 'accepted_driver_state.dart';

@Injectable()
class AcceptedDriverCubit extends Cubit<AcceptedDriverState> {
  final SocketService socketService;
  final UpdateDriverLocationUseCase updateDriverLocationUseCase;
  final UpdateTripStatusUseCase updateTripStatusUseCase;
  final AcceptDriverPaymentRequestUseCase acceptDriverPaymentRequestUseCase;
  final CancelDriverTripUseCase cancelTripUseCase;
  final EndDriverTripUseCase endDriverTripUseCase;
  final GetTripByIdUseCase getTripByIdUseCase;
  String tripIdValue = "";

  AcceptedDriverCubit(
    this.socketService,
    this.updateDriverLocationUseCase,
    this.cancelTripUseCase,
    this.endDriverTripUseCase,
    this.updateTripStatusUseCase,
    this.getTripByIdUseCase,
    this.acceptDriverPaymentRequestUseCase,
  ) : super(AcceptedDriverInitial());

  StreamSubscription<geo.Position>? locationSubscription;

  void joinDriverToTripRoom(
      {required String tripId, required Map<String, dynamic> tripData}) {
    tripIdValue = tripId;
    const geo.LocationSettings locationSettings = geo.LocationSettings(
      accuracy: geo.LocationAccuracy.bestForNavigation,
      distanceFilter: 8,
    );
    locationSubscription?.cancel();
    locationSubscription =
        geo.Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen(
      (event) {
        socketService.emitEvent("updating-trip", {
          "tripId": tripId,
          "trip": tripData,
          "driverLat": event.latitude,
          "driverLng": event.longitude,
        });
      },
    );
    socketService.emitEvent("addUserToTrip", {
      "tripId": tripId,
    });

    // Listen to trip cancellation from user side
    socketService.onEvent(
      "trip-cancelled",
      (p0) {
        if (!isClosed) {
          final cancelledTripId =
              p0 is Map ? (p0['tripId'] ?? p0['uuid']) : null;
          if (cancelledTripId == null || cancelledTripId.toString() == tripId) {
            emit(UpdateTripSuccess(
              isDelivered: false,
              tripModel:
                  TripModel(uuid: tripId, status: TripStatusEnum.cancelled),
              isCancel: true,
            ));
          }
        }
      },
    );
  }

  Future<void> getTripModelByUuid({required num id}) async {
    emit(GetTripByIdLoading());
    final response = await getTripByIdUseCase(id: id);
    emit(response.fold(
      (l) => GetTripByIdFailure(errorMsg: l.msg),
      (r) => GetTripByIdSuccess(tripModel: r.data),
    ));
  }

  void resetCubit() {
    if (tripIdValue.isNotEmpty) {
      socketService.disconnectFromRoom("payment-confirmation.$tripIdValue");
    }
    tripIdValue = "";
    if (!isClosed) {
      emit(AcceptedDriverInitial());
    }
  }

  Future<void> updateTripStatus(
      {required num id,
      required TripStatusEnum status,
      required String uuid}) async {
    emit(UpdateTripLoading());
    final response = await updateTripStatusUseCase(status: status, id: id);
    emit(response.fold(
      (l) {
        return UpdateTripFailed(msg: l.msg);
      },
      (r) {
        TripModel tripModel = r.data;
        socketService.emitEvent("update-trip-status", {
          "tripId": uuid,
          "status": status.name,
        });

        if (tripModel.paymentMethod == PaymentType.cash &&
            status == TripStatusEnum.delivered) {
          socketService.onEvent(
            "payment-confirmation.${tripModel.uuid}",
            (p0) {
              if (isClosed) return;
              emit(ListenToTripPaymentCashState());
            },
          );
        } else {
          if (tripModel.remaining_price != null &&
              tripModel.remaining_price != 0) {
            socketService.onEvent(
              "payment-confirmation.${tripModel.uuid}",
              (p0) {
                if (isClosed) return;
                emit(ListenToTripPaymentCashState());
              },
            );
          }
        }
        return UpdateTripSuccess(
            tripModel: r.data,
            isCancel: status == TripStatusEnum.cancelled,
            isDelivered: status == TripStatusEnum.delivered);
      },
    ));
  }

  Future<void> acceptPaymentRequest(
      {required String tripId,
      required num id,
      required bool driverAcceptConfirmation}) async {
    emit(AcceptPaymentRequestLoading());
    final response = await acceptDriverPaymentRequestUseCase(
        id: id, driverAcceptConfirmation: driverAcceptConfirmation);
    emit(response.fold(
      (l) => AcceptPaymentRequestFailure(msg: l.msg),
      (r) {
        socketService.emitEvent("payment-confirmation", {
          "tripId": tripId,
          "trip": r.response,
        });
        return AcceptPaymentRequestSuccess();
      },
    ));
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    if (tripIdValue.isNotEmpty) {
      socketService.disconnectFromRoom("payment-confirmation.$tripIdValue");
    }
    // Note: Not disconnecting from "trip-cancelled" as it's a shared event
    // The isClosed check in the listener prevents emitting after disposal
    return super.close();
  }
}
