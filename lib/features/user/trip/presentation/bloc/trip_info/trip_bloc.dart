import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:taxito/core/services/location/location_permission_service.dart';
import 'package:taxito/core/services/location/polyline_helper.dart';
import 'package:taxito/features/user/trip/domain/usecases/get_trip_by_uuid_use_case.dart';
import 'package:taxito/features/user/trip/domain/usecases/get_user_driver_use_case.dart';
import 'package:taxito/features/user/trip/presentation/bloc/trip_info/trip_state.dart';
import '../../../../../../core/services/location/map_helper.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../common/models/main_location_data.dart';
import '../../../../location/domain/usecases/get_details_by_latlng_use_case.dart';

@Injectable()
class TripBloc extends Cubit<TripState> {
  final GetPlaceDetailsByLatlng getPlaceDetailsByLatlng;
  final GetTripByUUidUseCase getTripByUUidUseCase;
  final GetUserDriverUseCase getUserDriverUseCase;
  LatLng? currentLocation;
  MainLocationData? startLocation;
  MainLocationData? endLocation;
  MainLocationData? driverLocation;
  GoogleMapController? googleMapController;
  final PolyLineHelper polyLineHelper;
  Timer? _debounce;
  Set<Marker> markers = {};
  Set<Polyline> polyines = {};
  int currentState = 0;

  TripBloc(
    this.getPlaceDetailsByLatlng,
    this.polyLineHelper,
    this.getUserDriverUseCase,
    this.getTripByUUidUseCase,
  ) : super(TripInitial());

  Future<void> getCurrentLocation() async {
    final Uint8List? markerIcon = await MapHelper().getBytesFromAsset(
      path: Assets.images.origin.path,
      width: 30,
    );
    emit(GetCurrentLocationLoadingState());
    try {
      final locationResult = await LocationPermissionService()
          .requestPermissionAndLocation();

      if (locationResult.status == LocationPermissionStatus.denied) {
        Location location = Location();
        bool serviceEnabled = await location.serviceEnabled();

        if (!serviceEnabled) {
          emit(LocationServiceDisabledState());
          return;
        } else {
          emit(LocationPermissionDeniedState());
          return;
        }
      }
      LatLng latLng = locationResult.location!;
      startLocation = MainLocationData(address: "", latLng: latLng, place: "");
      emit(GetCurrentLocationSuccess2State());
      final response = await getPlaceDetailsByLatlng(latlng: latLng);
      response.fold(
        (l) => emit(GetCurrentLocationFailureState(errorMsg: l.msg)),
        (r) {
          startLocation = MainLocationData(
            address: r.data,
            latLng: latLng,
            place: r.data,
          );
          markers.add(
            Marker(
              icon: BitmapDescriptor.bytes(markerIcon!),
              markerId: const MarkerId(AppStrings.origin),
              position: latLng,
            ),
          );
          googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: latLng, zoom: 14),
            ),
          );
          emit(GetCurrentLocationSuccessState());
        },
      );
    } catch (error) {
      emit(GetCurrentLocationFailureState(errorMsg: error.toString()));
    }
  }

  void onGoogleMapControllerCreated({required GoogleMapController map}) {
    googleMapController = map;
    emit(OnGoogleMapControllerCreatedState());
  }

  Future<void> submitTripPointEvent({
    required MainLocationData mainLocationData,
    required bool isStart,
  }) async {
    final Uint8List? markerIcon = await MapHelper().getBytesFromAsset(
      path: Assets.images.origin.path,
      width: 35,
    );
    final Uint8List? markerIcon1 = await MapHelper().getBytesFromAsset(
      path: Assets.images.destination.path,
      width: 35,
    );
    if (isStart) {
      startLocation = mainLocationData;
      markers.add(
        Marker(
          markerId: const MarkerId(AppStrings.origin),
          position: mainLocationData.latLng,
          icon: BitmapDescriptor.bytes(markerIcon!),
        ),
      );
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: mainLocationData.latLng, zoom: 14),
        ),
      );
    } else {
      endLocation = mainLocationData;
      markers.add(
        Marker(
          markerId: const MarkerId(AppStrings.destination),
          position: mainLocationData.latLng,
          icon: BitmapDescriptor.bytes(markerIcon1!),
        ),
      );
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: mainLocationData.latLng, zoom: 14),
        ),
      );
    }
    emit(
      SubmitTripPointSuccessSuccess(
        isStart: isStart,
        locationData: mainLocationData,
      ),
    );
  }

  Future<void> getDriverLocationEvent({
    required double lat,
    required double lng,
  }) async {
    final Uint8List? markerIcon = await MapHelper().getBytesFromAsset(
      path: Assets.images.carTop.path,
      width: 30,
    );
    double bearing = 0;
    if (markers.isNotEmpty) {
      final lastMarker = markers.first.position;
      final dx = lng - lastMarker.longitude;
      final dy = lat - lastMarker.latitude;
      bearing = (atan2(dx, dy) * 180 / pi);
    }

    markers.add(
      Marker(
        markerId: const MarkerId(AppStrings.driver),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.bytes(markerIcon!),
        rotation: bearing,
      ),
    );

    googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18),
    );

    emit(TrackDriverLocationState(lat: lat, lng: lng));
  }

  Future<void> changeCameraPosition({required LatLng lng}) async {
    if (currentState == 0) {
      final Uint8List? markerIcon = await MapHelper().getBytesFromAsset(
        path: Assets.images.origin.path,
        width: 30,
      );
      markers.add(
        Marker(
          icon: BitmapDescriptor.bytes(markerIcon!),
          markerId: const MarkerId(AppStrings.origin),
          position: lng,
        ),
      );
      if (_debounce?.isActive ?? false) {
        _debounce!.cancel();
      }
      _debounce = Timer(const Duration(seconds: 1), () async {
        final response = await getPlaceDetailsByLatlng(latlng: lng);
        response.fold((l) {}, (r) {
          startLocation = MainLocationData(
            address: r.data,
            latLng: lng,
            place: r.data,
          );
          emit(
            ChangeCameraPositionStartState(mainLocationData: startLocation!),
          );
        });
      });
    } else {
      final Uint8List? markerIcon = await MapHelper().getBytesFromAsset(
        path: Assets.images.destination.path,
        width: 30,
      );
      markers.add(
        Marker(
          icon: BitmapDescriptor.bytes(markerIcon!),
          markerId: const MarkerId(AppStrings.destination),
          position: lng,
        ),
      );
      if (_debounce?.isActive ?? false) {
        _debounce!.cancel();
      }
      _debounce = Timer(const Duration(seconds: 1), () async {
        final response = await getPlaceDetailsByLatlng(latlng: lng);
        response.fold((l) {}, (r) {
          endLocation = MainLocationData(
            address: r.data,
            latLng: lng,
            place: r.data,
          );
          emit(
            ChangeCameraPositionStartState(mainLocationData: startLocation!),
          );
        });
      });
    }
    emit(ChangeCameraPositionState(latLng: lng));
  }

  void changeCurrentState(int index) async {
    currentState = index;
    if (index == 2) {
      if (startLocation != null && endLocation != null) {
        Polyline? polyLine = await polyLineHelper.getPolyLine(
          origin: startLocation!.latLng,
          destination: endLocation!.latLng,
          place: endLocation!.address,
        );
        if (polyLine != null) {
          polyines.add(polyLine);
        }
      }
    }
    emit(ConfirmPointState(stateIndex: index));
  }

  void clearMarkers() {
    markers.clear();
    emit(ClearMarkersState());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
