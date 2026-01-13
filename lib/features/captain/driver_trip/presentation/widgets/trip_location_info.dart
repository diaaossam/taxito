import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/services/location/location_manager.dart';
import 'package:taxito/features/captain/driver_trip/presentation/widgets/trip_distance_design.dart';
import 'package:taxito/features/captain/driver_trip/presentation/widgets/trip_reject/trip_reject_counter.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../../core/data/models/trip_model.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import 'comminucation_with_driver_widget.dart';
import 'trip_info_widget.dart';

class TripLocationInfo extends StatelessWidget {
  final TripModel tripModel;
  final Function(bool)? onCancelTrip;
  final bool showActions;
  final bool showDistance;
  final Color? color;
  final LatLng? currentLocation;
  final Function(void) onCallBack;
  final bool showDate;

  const TripLocationInfo({
    super.key,
    required this.tripModel,
    this.onCancelTrip,
    required this.showActions,
    required this.onCallBack,
    this.color,
    required this.showDistance,
    this.currentLocation,
    this.showDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: showActions
          ? const EdgeInsets.symmetric(vertical: 14, horizontal: 10)
          : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: showActions
            ? Border.all(color: context.colorScheme.outline)
            : null,
        color: showActions ? context.colorScheme.onPrimary : null,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colorScheme.primary),
                ),
                child: CircleAvatar(
                  maxRadius: 30,
                  backgroundImage: NetworkImage(
                    tripModel.user?.profileImage ?? "",
                  ),
                  onBackgroundImageError: (exception, stackTrace) =>
                      AssetImage(Assets.images.dummyUser.path),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.bodyHeight * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: tripModel.user?.name ?? "",
                                fontWeight: FontWeight.w600,
                                textSize: 13,
                              ),
                              if (showDistance && currentLocation != null) ...[
                                8.verticalSpace,
                                AppText(
                                  text:
                                      "${context.localizations.distance1}  ${LocationManager.calculateDistance(tripModel.from!.latLng, currentLocation!)}  ${context.localizations.km}",
                                  fontWeight: FontWeight.w600,
                                  textSize: 12,
                                  color: context.colorScheme.shadow,
                                ),
                              ],
                              if (showDate && tripModel.createdAt != null) ...[
                                8.verticalSpace,
                                AppText(
                                  text:
                                      "${DateFormat.yMd().format(tripModel.createdAt!)} - ${DateFormat.jm().format(tripModel.createdAt!)}",
                                  fontWeight: FontWeight.w600,
                                  textSize: 12,
                                  color: context.colorScheme.shadow,
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (showActions) ...{
                          10.verticalSpace,
                          ComminucationWithDriverWidget(
                            tripModel: tripModel,
                            onCallBack: onCallBack,
                          ),
                        },
                      ],
                    ),
                    TripInfoWidget(tripModel: tripModel),
                    if (onCancelTrip != null) ...[
                      20.verticalSpace,
                      TripTimerDesign(callBack: onCancelTrip ?? (value) {}),
                    ],
                    10.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
          TripDistanceInfo(
            tripModel: tripModel,
            color: color ?? context.colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
