import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'presentation/widgets/address_dialog_design.dart';

class LocationHelper {
  Future<void> showLocationDailog({
    required BuildContext context,
    required Function(MyAddress) myAddress,
  }) async {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: AddressDialogDesign(
          onChoose: myAddress,
        ),
      ),
    );
  }

  Future<void> showLocationLoadingDailog({
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: PopScope(
            canPop: false,
            child: SizedBox(
              height: 200.h,
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                    40.verticalSpace,
                    AppText(
                      text: context.localizations.waitLocation,
                    fontWeight: FontWeight.w600,
                      maxLines: 3,textSize: 11,
                    )

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
