import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/data/models/orders.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../widgets/app_text.dart';

class OrderPaymentInfo extends StatelessWidget {
  final Orders orders;

  const OrderPaymentInfo({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          text: context.localizations.paymentType,
          fontWeight: FontWeight.bold,
        ),
        10.verticalSpace,
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
                        payment: orders.paymentMethod ?? PaymentType.cash,
                        context: context),fontWeight: FontWeight.w600,),
              ),
              AppImage.asset(Assets.icons.money2)
            ],
          ),
        ),
      ],
    );
  }
}
