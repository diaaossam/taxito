import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/trip/presentation/pages/choose_location_screen.dart';
import 'package:taxito/features/user/trip/presentation/pages/pay_trip_design.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../gen/assets.gen.dart';
import '../../../widgets/image_picker/app_image.dart';
import '../location/data/models/response/main_location_data.dart';
import 'data/models/trip_model.dart';
import 'presentation/widgets/rate_driver_page/pending_user_payment_dialog.dart';
import 'presentation/widgets/rate_driver_page/rating_success_dialog.dart';

class TripHelper {
  String formatTripDate({required DateTime date}) {
    return DateFormat.yMEd().format(date);
  }

  String formatTripTime({required DateTime date}) {
    return DateFormat.jm().format(date);
  }

  String formatTripDateTime({required DateTime date}) {
    return "${DateFormat.yMEd().format(date)} , ${DateFormat.jm().format(date)}";
  }

  Map<String, String> formatDateTimeToApi(DateTime dateTime) {
    String tripDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    String tripTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return {"trip_date": tripDate, "trip_time": tripTime};
  }

  Future<DateTime?> showDatePickerWidget({
    required BuildContext context,
  }) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      initialDate: DateTime.now(),
    );

    if (dateTime != null) {
      return dateTime;
    }
    return null;
  }

  Future<TimeOfDay?> showTimerPickerWidget({
    required BuildContext context,
  }) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      return time;
    }
    return null;
  }

  Future<MainLocationData?> searchForLocation({
    required BuildContext context,
    required bool isStart,
  }) async {
    final response = await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => ChooseLocationScreen(isStart: isStart),
    );
    return response;
  }

  Future<void> showPaymentMethods({
    required BuildContext context,
    required Function(PaymentType) paymentMethod,
  }) async {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => PayTripDesign(paymentMethod: paymentMethod),
    );
  }

  Future<void> showSuccessRating({required BuildContext context}) async {
    showCupertinoModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      builder: (context) => const RatingSuccessDialog(),
    );
  }

  Future<void> showSendPendingPaymentDialog({
    required BuildContext context,
    required TripModel tripModel,
    required Map<String, dynamic> map,
    required GlobalKey globalKey,
  }) async {
    showDialog(
      context: context,

      builder: (context) => PendingPaymentDialog(
        tripModel: tripModel,
        map: map,
        globalKey: globalKey,
      ),
    );
  }

  Future<void> showSuccessReport({
    required BuildContext context,
    required TripModel model,
  }) async {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        height: SizeConfig.bodyHeight * .5,
        child: AlertDialog(
          content: SizedBox(
            height: SizeConfig.bodyHeight * .5,
            child: Column(
              children: [
                SizedBox(height: SizeConfig.bodyHeight * .02),
                AppImage.asset(
                  Assets.images.email.path,
                  width: SizeConfig.bodyHeight * .2,
                  height: 100,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                AppText(
                  text: context.localizations.reportProblemTitle,
                  textSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                AppText(
                  text: "# ${model.uuid?.split("-").first}",
                  maxLines: 4,
                  align: TextAlign.center,
                  color: context.colorScheme.shadow,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                AppText(
                  text: context.localizations.reportProblemBody,
                  maxLines: 4,
                  align: TextAlign.center,
                  color: context.colorScheme.shadow,
                  textHeight: 1.8,
                ),
                const Spacer(),
                CustomButton(
                  text: context.localizations.backToTrip,
                  press: () => Navigator.pop(context),
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
