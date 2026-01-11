import 'package:aslol/core/bloc/socket/socket_cubit.dart';
import 'package:aslol/features/trip/presentation/widgets/google_map_widget.dart';
import 'package:aslol/widgets/loading/loading_widget.dart';
import 'package:aslol/widgets/location_permission_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../config/helper/keyboard.dart';
import '../../../../core/enum/trip_status_enum.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../widgets/app_failure.dart';
import '../../data/models/trip_model.dart';
import '../bloc/accepted_user_trip/accepted_user_trip_cubit.dart';
import '../bloc/trip_info/trip_bloc.dart';
import '../bloc/trip_info/trip_state.dart';
import 'request_trip/request_trip_design.dart';

class TripBody extends StatefulWidget {
  final TripModel? tripModel;

  const TripBody({
    super.key,
    this.tripModel,
  });

  @override
  State<TripBody> createState() => _TripBodyState();
}

class _TripBodyState extends State<TripBody> {
  double requestHeight = SizeConfig.bodyHeight * .35;
  int index = 0;
  final GlobalKey<RequestTripDesignState> requestKey =
  GlobalKey<RequestTripDesignState>();

  @override
  void initState() {
    context.read<SocketCubit>().initSocketConnection();
    if (widget.tripModel != null) {
      if (widget.tripModel?.status == TripStatusEnum.delivered) {
        context.read<AcceptedUserTripCubit>().joinUserToTripRoom(model: widget.tripModel!);
        index = 3;
      }
      else {
        if (widget.tripModel?.driver != null) {
          index = 2;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketCubit, SocketState>(
      builder: (context, state) {
        return BlocConsumer<TripBloc, TripState>(
          listener: (context, state) {
            if (state is ConfirmPointState) {
              KeyboardUtil.hideKeyboard(context);
              if (state.stateIndex == 1) {
                setState(() => requestHeight = SizeConfig.bodyHeight * .48);
              }
            }
          },
          builder: (context, state) {
            final bloc = context.read<TripBloc>();
            if (state is GetCurrentLocationLoadingState) {
              return const LoadingWidget();
            } else if (state is LocationPermissionDeniedState) {
              return LocationPermissionErrorWidget(
                errorType: LocationErrorType.permissionDenied,
                onRetry: () => bloc.getCurrentLocation(),
              );
            } else if (state is LocationServiceDisabledState) {
              return LocationPermissionErrorWidget(
                errorType: LocationErrorType.serviceDisabled,
                onRetry: () => bloc.getCurrentLocation(),
              );
            } else if (state is GetCurrentLocationFailureState ||
                state is GetDriversFailureState) {
              return const AppFailureWidget();
            } else if (getCurrentState(state)) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: requestHeight),
                    child: GoogleMapWidget(
                      myLocationCallback: () async {
                        final position = await Geolocator.getCurrentPosition();
                        final newLatLng =
                            LatLng(position.latitude, position.longitude);
                        bloc.googleMapController
                            ?.animateCamera(CameraUpdate.newLatLng(newLatLng));
                      },
                      polylines: bloc.polyines,
                      onCameraMove: (cameraPosition) {
                        if (widget.tripModel != null) {
                          return null;
                        } else {
                          if (bloc.currentState == 0 ||
                              bloc.currentState == 1) {
                            return bloc.changeCameraPosition(
                              lng: cameraPosition.target,
                            );
                          }
                        }
                      },
                      latLng: bloc.startLocation!.latLng,
                      onMapCreated: (controller) =>
                          bloc.onGoogleMapControllerCreated(map: controller),
                      markers: bloc.markers,
                    ),
                  ),
                  Positioned(
                      bottom: 0.0,
                      child: RequestTripDesign(
                        height: requestHeight,
                        initialIndex: index,
                        onChangeIndex: (p0) => setState(() => index = p0),
                        tripModel: widget.tripModel,
                        key: requestKey,
                      )),
                  if (index != 2 && index != 3)
                    Positioned(
                        top: 30.0,
                        right: 20,
                        child: InkWell(
                          onTap: () => requestKey.currentState?.onWillPop(),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.black)),
                            child: SvgPicture.asset(Assets.icons.arrowBack),
                          ),
                        )),
                ],
              );
            } else {
              return const Center();
            }
          },
        );
      },
    );
  }

  bool getCurrentState(TripState state) {
    return state is GetCurrentLocationSuccessState ||
        state is OnGoogleMapControllerCreatedState ||
        state is GetCurrentLocationSuccess2State ||
        state is GetCurrentLocationSuccess3State ||
        state is SubmitTripPointSuccessSuccess ||
        state is ChangeCameraPositionState ||
        state is ChangeCameraPositionStartState ||
        state is ClearMarkersState ||
        state is GetDriversSuccessState ||
        state is ConfirmPointState ||
        state is TrackDriverLocationState;
  }
}
