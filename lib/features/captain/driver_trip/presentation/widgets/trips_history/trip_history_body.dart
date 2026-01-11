import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/driver_trip/data/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/enum/payment_type.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../../delivery_order/presentation/widgets/track_order/comminucation_order.dart';
import 'driver_trip_item.dart';

class TripHistoryBody extends StatelessWidget {
  final TripModel tripModel;

  const TripHistoryBody({super.key, required this.tripModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DriverTripItem(
            tripModel: tripModel,
            isDriver: true,
            showDate: true,
            status: tripModel.status!.name,
          ),
          SizedBox(height: SizeConfig.bodyHeight*.02,),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.bodyHeight * .02,
                horizontal: SizeConfig.screenWidth * .02),
            margin: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.outline),
                color: context.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(10)),
            child:  Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                  NetworkImage(tripModel.user?.profileImage ?? ""),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(text: tripModel.user?.name??"",fontWeight: FontWeight.w600,),
                      6.verticalSpace,
                      AppText(text: tripModel.user?.address??"",fontWeight: FontWeight.w600,),
                    ],
                  ),
                ),
                ComminucationOrderWidget(phone: tripModel.user?.phone ?? "",),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.bodyHeight*.04,),
          AppText(
            text: context.localizations.paymentType,
            fontWeight: FontWeight.bold,
          ),
          20.verticalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colorScheme.onPrimaryContainer),
            child: Row(
              children: [
                Expanded(
                  child: AppText(
                    text: handlePaymentTypeToString(
                        payment: tripModel.paymentMethod ?? PaymentType.cash,
                        context: context),fontWeight: FontWeight.w600,),
                ),
                AppImage.asset(Assets.icons.money2)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
