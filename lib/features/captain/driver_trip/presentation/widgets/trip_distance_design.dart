import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/data/models/trip_model.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/app_image.dart';

class TripDistanceInfo extends StatelessWidget {
  final TripModel tripModel;
  final Color ? color;

  const TripDistanceInfo({super.key, required this.tripModel, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.bodyHeight * .02,
          horizontal: SizeConfig.screenWidth * .02),
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          color: color ??context.colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text:
                    "${tripModel.duration.toString()} ${context.localizations.minute}",
                fontWeight: FontWeight.w600,
              ),
              10.verticalSpace,
              Row(
                children: [
                  AppImage.asset(
                    Assets.icons.clock,
                    color: context.colorScheme.primary,
                  ),
                  4.horizontalSpace,
                  AppText(text: context.localizations.tripDuration),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text:
                    "${tripModel.distance.toString()} ${context.localizations.km}",
                fontWeight: FontWeight.w600,
              ),
              10.verticalSpace,
              Row(
                children: [
                  AppImage.asset(
                    Assets.icons.ditance,
                    color: context.colorScheme.primary,
                  ),
                  4.horizontalSpace,
                  AppText(text: context.localizations.distance),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text:
                    "${tripModel.totalPrice.toString()} ${context.localizations.iqd}",
                fontWeight: FontWeight.w600,
              ),
              10.verticalSpace,
              Row(
                children: [
                  AppImage.asset(
                    Assets.icons.coin,
                  ),
                  4.horizontalSpace,
                  AppText(text: context.localizations.totalPrice1),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
