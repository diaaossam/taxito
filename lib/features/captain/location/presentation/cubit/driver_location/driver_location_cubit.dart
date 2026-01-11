import 'dart:async';
import 'dart:ui';
import 'package:taxito/features/captain/location/presentation/cubit/driver_location/driver_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/enum/choose_enum.dart';
import '../../../../../../core/services/location/location_permission_service.dart';
import '../../../../../../core/services/location/polyline_helper.dart';
import '../../../../../../core/services/socket/socket.dart';
import '../../../../auth/data/models/response/user_model_helper.dart';
import '../../../../driver_trip/data/models/trip_model.dart';
import '../../../domain/usecases/update_driver_location_use_case.dart';

@Injectable()
class DriverLocationCubit extends Cubit<DriverLocationState> {
  final SocketService socketService;
  final UpdateDriverLocationUseCase updateDriverLocationUseCase;
  final PolyLineHelper polyLineHelper;

  DriverLocationCubit(
    this.socketService,
    this.updateDriverLocationUseCase,
    this.polyLineHelper,
  ) : super(DriverLocationInitial());

  Map<String, Marker> markers = {};
  LatLng? currentLatLng;
  Set<Polyline> polyines = {};

  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  StreamSubscription<geo.Position>? locationSubscription;
  BitmapDescriptor? icon;

  Future<void> getCurrentDriverLocation() async {
    currentLatLng = (await LocationPermissionService().requestPermissionAndLocation()).location;
    emit(GetCurrentDriverLocation());
  }

  void drawPolyline({
    required TripModel tripModel,
    required bool isInTrip,
  }) async {
    if (currentLatLng != null) {
      if (!isInTrip) {
        if (tripModel.from != null) {
          Polyline? polyLine = await polyLineHelper.getPolyLine(
            origin: currentLatLng!,
            destination: tripModel.from!.latLng,
            place: tripModel.from!.address,
          );
          if (polyLine != null) {
            polyines.add(polyLine);
          }
        }
      } else {
        if (tripModel.to != null) {
          Polyline? polyLine = await polyLineHelper.getPolyLine(
            origin: currentLatLng!,
            destination: tripModel.to!.latLng,
            place: tripModel.to!.address,
          );
          if (polyLine != null) {
            polyines.add(polyLine);
          }
        }
      }
    }
    emit(DrawPolylineState());
  }

  void onMapController({required GoogleMapController map}) {
    controller.complete(map);
    emit(OnGoogleMapControllerState());
  }

  Future<void> getDriverStreamLocation({
    required ChooseEnum chooseEnum,
    bool isDelivery = false,
  }) async {
    if (chooseEnum == ChooseEnum.no) {
      locationSubscription?.cancel();
      socketService.emitEvent("update-status", {
        "driverId": UserDataService().getUserData()?.id,
        "isOnline": false,
        "hasTrip": false,
        "driverType": isDelivery ? "order" : "delivery",
        "location": {"lat": 0.0, "lng": 0.0},
      });
    }
    else {
      emit(GetCurrentLocationLoadingState());
      if (!isDelivery) {
        icon = await LocationPermissionService.initIcon();
      }
      try {
        const geo.LocationSettings locationSettings = geo.LocationSettings(
          accuracy: geo.LocationAccuracy.bestForNavigation,
          distanceFilter: 8,
        );
        if (!isDelivery) {
          markers['car'] = Marker(
            markerId: const MarkerId("car"),
            position: currentLatLng!,
            icon: icon ?? BitmapDescriptor.defaultMarker,
          );
        }
        locationSubscription?.cancel();
        locationSubscription =
            geo.Geolocator.getPositionStream(
              locationSettings: locationSettings,
            ).listen((event) {
              if (currentLatLng != null) {
                updateLocation(
                  lat: event.latitude,
                  isDelivery: isDelivery,
                  long: event.longitude,
                );
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
  }

  Future<void> updateLocation({
    required double lat,
    required double long,
    required bool isDelivery,
  }) async {
    LatLng newLatLng = LatLng(lat, long);
    socketService.emitEvent("update-status", {
      "driverId": UserDataService().getUserData()?.id,
      "isOnline": true,
      "hasTrip": false,
      "driverType": isDelivery ? "order" : "delivery",
      "location": {"lat": lat, "lng": long},
    });
    updateDriverLocationUseCase(lat: lat, lng: long);
    if (newLatLng != currentLatLng) {
      markers['car'] = Marker(
        markerId: const MarkerId("car"),
        position: currentLatLng!,
        icon: icon ?? BitmapDescriptor.defaultMarker,
        rotation: LocationPermissionService().calculateCarDegree(
          currentLatLng!,
          newLatLng,
        ),
        anchor: const Offset(0.5, 0.5),
      );
      currentLatLng = newLatLng;
      emit(UpdateDriverLocationState(lat: lat, lon: long));
    }
  }

  Future<void> forceUpdateLocation() async {
    if (currentLatLng != null && !isClosed) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
          ),
        );
        updateLocation(
          lat: position.latitude,
          long: position.longitude,
          isDelivery: UserDataService().getUserData()?.driverType != "taxi_driver",
        );
      } catch (e) {
        // Handle error silently or log it
      }
    }
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    return super.close();
  }
}
