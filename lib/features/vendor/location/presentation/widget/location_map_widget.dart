import 'package:app_settings/app_settings.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/services/location/location_permission_service.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_failure.dart';
import '../../../../../widgets/back_widget.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/loading/loading_widget.dart';
import '../../data/models/location_entity.dart';
import '../cubit/location_cubit.dart';
import 'google_map_widget.dart';

class LocationMapBody extends StatelessWidget {
  const LocationMapBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        final bloc = context.read<LocationCubit>();
        if (state is GetLocationLoading || state is LocationInitial) {
          return const LoadingWidget();
        } else if (state is GetLocationSuccess || state is PickLocationState) {
          return Stack(
            children: [
              GoogleMapWidget(
                latLng: bloc.latLng!,
                onTap: (value) => bloc.pickLocation(lat: value),
                markers: {
                  Marker(
                    markerId: const MarkerId('markerId'),
                    position: bloc.latLng!,
                  ),
                },
              ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Padding(
                  padding: screenPadding(),
                  child: CustomButton(
                    text: context.localizations.confirm,
                    press: () async {
                      String address =
                          await LocationPermissionService.getMyAddress(
                            latLng: bloc.latLng!,
                          );
                      LocationEntity locationEntity = LocationEntity(
                        address: address.isEmpty
                            ? context.localizations.locationPickedSuccessFully
                            : address,
                        lat: bloc.latLng!.latitude,
                        lon: bloc.latLng!.longitude,
                      );
                      Navigator.pop(context, locationEntity);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 0,
                child: Padding(
                  padding: screenPadding(),
                  child: BackArrowWidget(
                    callback: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          );
        } else if (state is LocationPermissionDenied) {
          // Permission denied - show message based on whether it's permanent or not
          return AppFailureWidget(
            body: state.isPermanentlyDenied
                ? context.localizations.locationPermissionDeniedForever
                : context.localizations.locationPermissionDenied,
            height: SizeConfig.bodyHeight * .1,
            buttonText: state.isPermanentlyDenied
                ? context.localizations.openSettings
                : context.localizations.tryAgain,
            back: () {
              Navigator.pop(context);
            },
            callback: () async {
              if (state.isPermanentlyDenied) {
                await bloc.openSettings();
              } else {
                await bloc.requestLocation();
              }
            },
          );
        } else if (state is GetLocationFailure) {
          return AppFailureWidget(
            body: state.error,
            height: SizeConfig.bodyHeight * .1,
            buttonText: context.localizations.tryAgain,
            callback: () {
              Navigator.pop(context);
              AppSettings.openAppSettings(type: AppSettingsType.location);
            },
          );
        } else {
          return const Center();
        }
      },
    );
  }
}
