import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:taxito/core/services/socket/socket.dart';
import 'package:taxito/features/common/models/orders.dart';

part 'delivery_location_state.dart';

@Injectable()
class DeliveryLocationCubit extends Cubit<DeliveryLocationState> {
  final SocketService socketService;

  DeliveryLocationCubit(this.socketService) : super(DeliveryLocationInitial());

  StreamSubscription<Position>? locationSubscription;
  LatLng? currentLatLng;
  Timer? locationUpdateTimer;

  Future<void> getDriverStreamLocation({required Orders order}) async {
    emit(GetCurrentLocationLoadingState());
    try {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 8,
      );
      locationSubscription?.cancel();
      locationSubscription =
          Geolocator.getPositionStream(
            locationSettings: locationSettings,
          ).listen((event) {
            socketService.emitEvent("updating-order", {
              "orderId": order.id,
              "order": order.toJson(),
              "driverLat": event.latitude,
              "driverLng": event.longitude,
            });
          });

      locationUpdateTimer?.cancel();
      locationUpdateTimer = Timer.periodic(const Duration(minutes: 1), (
        timer,
      ) async {
        if (currentLatLng != null && !isClosed) {
          try {
            Position position = await Geolocator.getCurrentPosition(
              locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.bestForNavigation,
              ),
            );
            socketService.emitEvent("updating-order", {
              "orderId": order.id,
              "order": order.toJson(),
              "driverLat": position.latitude,
              "driverLng": position.longitude,
            });
          } catch (e) {
            // Handle error silently or log it
          }
        }
      });

      if (!isClosed) {
        emit(GetCurrentLocationSuccessState());
      }
    } catch (error) {
      if (!isClosed) {
        emit(GetCurrentLocationFailureState(errorMsg: error.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    currentLatLng = null;
    locationUpdateTimer?.cancel();
    return super.close();
  }
}
