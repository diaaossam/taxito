import 'package:taxito/core/enum/trip_status_enum.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/captain/driver_trip/presentation/widgets/trips_history/rating_bar_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import '../../pages/driver_history_details_screen.dart';
import '../trip_location_info.dart';

class DriverTripItem extends StatelessWidget {
  final TripModel tripModel;
  final bool isDriver;
  final String status;
  final bool showDate;

  const DriverTripItem({
    super.key,
    required this.tripModel,
    required this.isDriver,
    required this.status,
    this.showDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (status == TripStatusEnum.delivered.name) {
          context.navigateTo(DriverHistoryDetailsScreen(tripModel: tripModel));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.bodyHeight * .02,
          horizontal: SizeConfig.screenWidth * .02,
        ),
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          color: context.colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    text:
                        "${context.localizations.trip} #${tripModel.uuid?.split("-").first}",
                    fontWeight: FontWeight.w600,
                    textSize: 15,
                  ),
                ),
                if (tripModel.rate != null)
                  RatingBarDesign(rating: tripModel.rate!),
              ],
            ),
            SizedBox(height: SizeConfig.bodyHeight * .015),
            TripLocationInfo(
              tripModel: tripModel,
              showDate: showDate,
              showDistance: false,
              showActions: false,
              onCallBack: (p0) {},
            ),
          ],
        ),
      ),
    );
  }
}
