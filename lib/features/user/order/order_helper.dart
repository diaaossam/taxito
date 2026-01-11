import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHelper {
  Future<void> showSuccessOrderDialog({
    required BuildContext context,
    required num id,
  }) async {
/*    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.bodyHeight * .65,
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                Center(
                  child: AppImage.asset(
                    fit: BoxFit.cover,
                    height: SizeConfig.bodyHeight * .3,
                    Assets.images.successOrder.path,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                AppText(
                  text: context.localizations.orderPlacedSuccess,
                  textSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                AppText(text: context.localizations.orderPlacedSuccess2),
                SizedBox(
                  height: SizeConfig.bodyHeight * .08,
                ),
                CustomButton(
                    text: context.localizations.trackOrder,
                    press: () => context.navigateTo(TrackOrderScreen(
                          id: id,
                        ))),
              ],
            ),
          ),
        ),
      ),
    ).whenComplete(
      () => context.navigateToAndFinish(const MainLayout()),
    );*/
  }

  String formatDateTime(DateTime dateTime) {
    final time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    final date =
        "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
    return "$date . $time";
  }

  String formatDate(DateTime dateTime) {
    final date =
        "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
    return date;
  }

  Future<void> showConfirmOrderDialog({
    required BuildContext context,
    required Function(bool) onReceive,
  }) async {
    /* showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.bodyHeight * .54,
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                Center(
                  child: AppImage.asset(
                    fit: BoxFit.cover,
                    height: SizeConfig.bodyHeight * .12,
                    Assets.icons.box2,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                AppText(
                  text: context.localizations.confirmOrderTitle,
                  textSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                AppText(
                  text: context.localizations.confirmOrder,
                  maxLines: 2,
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .08,
                ),
                CustomButton(
                    text: context.localizations.confirmOrderTitle,
                    press: () {
                      onReceive(true);
                      Navigator.pop(context);
                    }),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                CustomButton(
                  text: context.localizations.cancel,
                  press: () {
                    onReceive(false);
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.transparent,
                  textColor: context.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
  }
}

String formatPrice({
  required dynamic price,
  int decimalDigits = 0,
  String locale = 'en',
}) {
  final formatter = NumberFormat.decimalPattern(locale)
    ..minimumFractionDigits = decimalDigits
    ..maximumFractionDigits = decimalDigits;
  return formatter.format(num.tryParse(price));
}
