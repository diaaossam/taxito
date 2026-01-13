import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/models/trip_model.dart';
import '../../../../../widgets/app_text.dart';

class PaymentTypeInfo extends StatelessWidget {
  final TripModel trip;

  const PaymentTypeInfo({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppText(
            text: context.localizations.paymentType,
            fontWeight: FontWeight.bold,
          ),
        ),
        10.verticalSpace,
        Container(
          decoration: BoxDecoration(color: context.colorScheme.onPrimary),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colorScheme.outline),
              color: context.colorScheme.inversePrimary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  fontWeight: FontWeight.w500,
                  text: trip.paymentMethod.toString() == "cash"
                      ? context.localizations.cash1
                      : context.localizations.visa,
                ),
                AppImage.asset(Assets.icons.coin),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
