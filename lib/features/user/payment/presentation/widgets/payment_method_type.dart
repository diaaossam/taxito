import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../order/data/models/payment_model.dart';

class PaymentMethodTypeWidget extends StatelessWidget {
  final bool selected;
  final PaymentModel model;

  const PaymentMethodTypeWidget({
    super.key,
    required this.selected,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.bodyHeight * .006,
        horizontal: SizeConfig.screenWidth * .02,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selected
              ? context.colorScheme.primary
              : context.colorScheme.outline,
          width: selected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              text: model.title,
              fontWeight: FontWeight.w600,
              textSize: 14,
            ),
          ),
          10.horizontalSpace,
          if (model.paymentMethod == PaymentType.wallet ||
              model.paymentMethod == PaymentType.cash)
            Container(
              padding: const EdgeInsets.all(10),
              child: AppImage.asset(model.icon, height: 30.h, width: 30.h),
            )
          else
            AppImage.asset(model.icon, height: 50.h, width: 50.h),
        ],
      ),
    );
  }
}
