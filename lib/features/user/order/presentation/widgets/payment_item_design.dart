import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/order/data/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/image_picker/app_image.dart';

class PaymentItemDesign extends StatelessWidget {
  final bool isSelected;
  final PaymentModel paymentModel;

  const PaymentItemDesign(
      {super.key, required this.isSelected, required this.paymentModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * .04,
          ),
      decoration: BoxDecoration(
          color: context.colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(40)),
      child: Row(
        children: [
          AppImage.asset(
            isSelected ? Assets.icons.radioOn: Assets.icons.radioOff,
            height: 25.h,
            width: 25.h,
          ),
          Container(
              height: 45.h,
              width: 45.h,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: AppImage.asset(paymentModel.icon)),
          10.horizontalSpace,
          Expanded(
            child: AppText(
              text: paymentModel.title,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}
