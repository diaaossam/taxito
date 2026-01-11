import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../data/models/response/orders.dart';

class OrderPriceSummary extends StatelessWidget {
  final Orders orders;

  const OrderPriceSummary({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: screenPadding(),
          child: AppText(
            text: context.localizations.orderSummary,
            fontWeight: FontWeight.w600,
            textSize: 14,
          ),
        ),
        SizedBox(height: SizeConfig.bodyHeight * .01),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * .03,
            vertical: SizeConfig.bodyHeight * .025,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: screenPadding(),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(text: context.localizations.productPrice),
                    ),
                    AppText(
                      text: "${orders.totalPrice} ${context.localizations.iqd}",
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                15.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: AppText(text: context.localizations.shippingCost),
                    ),
                    AppText(
                      text:
                          "${orders.shippingCost} ${context.localizations.iqd}",
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                15.verticalSpace,
                if (orders.discountAmount != null &&
                    orders.discountAmount != 0) ...{
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          color: context.colorScheme.error,
                          text: context.localizations.discount,
                        ),
                      ),
                      AppText(
                        color: context.colorScheme.error,
                        text:
                            "${orders.discountAmount} ${context.localizations.iqd}",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  15.verticalSpace,
                },
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        text: context.localizations.totalPrice,
                        fontWeight: FontWeight.w700,
                        textSize: 15,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                    AppText(
                      text: "${orders.finalPrice} ${context.localizations.iqd}",
                      fontWeight: FontWeight.w700,
                      textSize: 15,
                      color: context.colorScheme.tertiary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
