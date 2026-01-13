import 'package:taxito/core/enum/trip_status_enum.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import '../found_driver_page/trip_user_info_widget.dart';

class DriverTripItem extends StatelessWidget {
  final TripModel tripModel;
  final bool isDriver;
  final Function(TripModel)? onCancel;
  final Function(TripModel)? onSearch;
  final Function(TripModel)? onGetDetails;

  const DriverTripItem({
    super.key,
    required this.tripModel,
    required this.isDriver,
    this.onCancel,
    this.onSearch,
    this.onGetDetails,
  });

  Color _handleColor({required BuildContext context}) {
    if (tripModel.status == TripStatusEnum.cancelled) {
      return context.colorScheme.error;
    } else if (tripModel.status == TripStatusEnum.coming) {
      return Colors.blue;
    }
    return context.colorScheme.tertiary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.bodyHeight * .02,
        horizontal: SizeConfig.screenWidth * .02,
      ),
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline),
        color: context.colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppImage.asset(Assets.images.taxi.path, height: 35.h),
              5.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: "${context.localizations.tripId}:",
                          fontWeight: FontWeight.w500,
                          textSize: 12,
                        ),
                        5.horizontalSpace,
                        AppText(
                          text: "${tripModel.uuid?.split("-").first}",
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                          color: context.colorScheme.primary,
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    AppText(
                      text:
                          "${DateFormat.yMd().format(tripModel.acceptedAt ?? DateTime.now())} . ${DateFormat.jm().format(tripModel.acceptedAt ?? DateTime.now())}",
                      fontWeight: FontWeight.w600,
                      textSize: 12,
                      color: context.colorScheme.shadow,
                    ),
                  ],
                ),
              ),
              5.horizontalSpace,
              AppText(
                fontWeight: FontWeight.w600,
                color: _handleColor(context: context),
                textSize: 12,
                text: handleTripStatusEnumToString(
                  tripStatusEnum: tripModel.status!,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          TripInfoWidget(tripModel: tripModel),
          20.verticalSpace,
          Row(
            children: [
              if (onSearch != null)
                Expanded(
                  child: CustomButton(
                    text: context.localizations.searchForDriver,
                    press: () => onSearch!(tripModel),
                    height: 45.h,
                  ),
                ),
              10.horizontalSpace,
              if (onCancel != null)
                Expanded(
                  child: CustomButton(
                    text: context.localizations.cancelTrip,
                    backgroundColor: context.colorScheme.error,
                    borderColor: context.colorScheme.error,
                    press: () => onCancel!(tripModel),
                    height: 45.h,
                  ),
                ),
            ],
          ),
          10.verticalSpace,
          if (onGetDetails != null) ...[
            CustomButton(
              text: context.localizations.tripDetails,
              press: () => onGetDetails!(tripModel),
              height: 45.h,
            ),
            10.verticalSpace,
          ],
        ],
      ),
    );
  }
}
