import 'package:taxito/features/captain/location/presentation/cubit/driver_location/driver_location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../../../core/enum/choose_enum.dart';
import '../../../../../../core/enum/trip_status_enum.dart';
import '../../../../../../widgets/app_failure.dart';
import '../../../../../../widgets/loading/loading_widget.dart';
import '../../../../../common/models/user_model_helper.dart';
import '../../../../location/presentation/cubit/driver_location/driver_location_cubit.dart';
import '../../cubit/driver_home/driver_home_cubit.dart';
import '../driver_main_layout/driver_home_actions.dart';

class DriverLocationWidget extends StatefulWidget {
  final Function(ChooseEnum) callbackAvailability;
  final TripModel? tripModel;

  const DriverLocationWidget({
    super.key,
    required this.callbackAvailability,
    this.tripModel,
  });

  @override
  State<DriverLocationWidget> createState() => _DriverLocationWidgetState();
}

class _DriverLocationWidgetState extends State<DriverLocationWidget>
    with WidgetsBindingObserver {
  bool _polylineDrawnForWaitingDriver = false;
  bool _polylineDrawnForInProgress = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
   // final _cubit = context.read<DriverLocationCubit>();
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.resumed:
        context.read<DriverHomeCubit>().initTrip();
        widget.callbackAvailability(
          UserDataService().getUserData()?.isAvailableEnum ?? ChooseEnum.yes,
        );
       // _cubit.forceUpdateLocation();
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<DriverLocationCubit>()..getCurrentDriverLocation(),
      child: BlocConsumer<DriverLocationCubit, DriverLocationState>(
        listener: (context, state) {
          if (state is GetCurrentDriverLocation) {
            context.read<DriverLocationCubit>().getDriverStreamLocation(
              chooseEnum: ChooseEnum.yes,
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<DriverLocationCubit>();
          if (state is GetCurrentLocationLoadingState ||
              state is DriverLocationInitial) {
            return const LoadingWidget();
          } else if (getState(state)) {
            if (widget.tripModel != null) {
              if (bloc.polyines.isEmpty &&
                  widget.tripModel!.status == TripStatusEnum.waitingDriver &&
                  !_polylineDrawnForWaitingDriver) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  bloc.drawPolyline(
                    tripModel: widget.tripModel!,
                    isInTrip: false,
                  );
                  _polylineDrawnForWaitingDriver = true;
                });
              } else if (widget.tripModel!.status == TripStatusEnum.started &&
                  !_polylineDrawnForInProgress) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  bloc.drawPolyline(
                    tripModel: widget.tripModel!,
                    isInTrip: true,
                  );
                  _polylineDrawnForInProgress = true;
                });
              }
            }
            return Stack(
              children: [
                Animarker(
                  markers: bloc.markers.values.toSet(),
                  curve: Curves.bounceInOut,
                  duration: const Duration(milliseconds: 3000),
                  mapId: bloc.controller.future.then((value) => value.mapId),
                  child: GoogleMap(
                    polylines: bloc.polyines,
                    onMapCreated: (p0) => bloc.onMapController(map: p0),
                    initialCameraPosition: CameraPosition(
                      target: bloc.currentLatLng!,
                      zoom: 14,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: InkWell(
                    onTap: () {
                      bloc.controller.future.then((value) {
                        value.animateCamera(
                          CameraUpdate.newLatLng(bloc.currentLatLng!),
                        );
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsetsDirectional.only(start: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      child: const Icon(Icons.my_location),
                    ),
                  ),
                ),
                DriverHomeActions(
                  callbackAvailability: (p0) {
                    context.read<DriverLocationCubit>().getDriverStreamLocation(
                      chooseEnum: p0,
                    );
                    widget.callbackAvailability(p0);
                  },
                ),
              ],
            );
          } else if (state is GetCurrentLocationFailureState) {
            return AppFailureWidget(body: state.errorMsg);
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  bool getState(DriverLocationState state) {
    return state is OnGoogleMapControllerState ||
        state is GetCurrentDriverLocation ||
        state is DrawPolylineState ||
        state is UpdateDriverLocationState ||
        state is GetCurrentLocationSuccessState;
  }
}
