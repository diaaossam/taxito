import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../core/data/models/trip_model.dart';
import '../../../core/utils/app_size.dart';
import '../../../gen/assets.gen.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/image_picker/app_image.dart';
import 'presentation/widgets/confirmation_driver_payment_dialog.dart';
import 'presentation/widgets/driver_trip.dart';

class DriverTripHelper {
  Future<void> showConfirmationPaymentDialog({
    required BuildContext context,
    required TripModel tripModel,
  }) async {
    showDialog(
      context: context,
      builder: (context) => ConfirmationPaymentDialog(tripModel: tripModel),
    );
  }

  Future<void> showTripBottomNav({
    required BuildContext context,
    required TripModel model,
    required VoidCallback onCancel,
  }) async {
    showCupertinoModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      bounce: true,
      expand: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: DriverTripWidget(tripModel: model, onCancel: onCancel),
        );
      },
    );
  }

  Future<bool> showCancelTripDialog({required BuildContext context}) async {
    final response = await showDialog(
      context: context,
      builder: (context) => SizedBox(
        height: SizeConfig.bodyHeight * .45,
        child: AlertDialog(
          insetPadding: EdgeInsets.zero,
          content: SizedBox(
            height: SizeConfig.bodyHeight * .45,
            child: Column(
              children: [
                SizedBox(height: SizeConfig.bodyHeight * .04),
                AppImage.asset(
                  Assets.images.cancelTrip.path,
                  width: SizeConfig.bodyHeight * .2,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .04),
                AppText(
                  text: context.localizations.cancelTripConfirm,
                  textSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                AppText(
                  text: context.localizations.cancelTripConfirmBody,
                  maxLines: 4,
                  align: TextAlign.center,
                  color: context.colorScheme.shadow,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 50.h,
                        text: context.localizations.yes,
                        press: () => Navigator.pop(context, true),
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: CustomButton(
                        height: 50.h,
                        backgroundColor: Colors.transparent,
                        textColor: context.colorScheme.primary,
                        text: context.localizations.no,
                        press: () => Navigator.pop(context, false),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return response ?? false;
  }
}
