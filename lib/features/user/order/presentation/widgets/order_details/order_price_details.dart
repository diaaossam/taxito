import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_divider_design.dart';
import '../../../data/models/orders.dart';

class PaymentPriceOrder extends StatelessWidget {
  final Orders orders;

  const PaymentPriceOrder({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * .02,
        vertical: SizeConfig.bodyHeight * .02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: context.colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: context.localizations.paymentType,
            fontWeight: FontWeight.bold,
            textSize: 14,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * .04,
              vertical: SizeConfig.bodyHeight * .015,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                AppImage.asset(
                  getPaymentData(
                    context: context,
                    type: orders.paymentMethod!,
                  )['image'],
                  height: 40,
                  width: 40,
                ),
                SizedBox(width: 10.w),
                AppText(
                  text: getPaymentData(
                    context: context,
                    type: orders.paymentMethod!,
                  )['title'],
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          const CustomDividerDesign(),
          SizedBox(height: SizeConfig.bodyHeight * .02),
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
                        child: AppText(
                          text: context.localizations.productPrice,
                        ),
                      ),
                      AppText(
                        text:
                            "${orders.totalPrice} ${context.localizations.iqd}",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: context.localizations.shippingCost,
                        ),
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
                        text:
                            "${orders.finalPrice} ${context.localizations.iqd}",
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
      ),
    );
  }

  Map<String, dynamic> getPaymentData({
    required PaymentType type,
    required BuildContext context,
  }) {
    Map<String, dynamic> map = {};
    switch (type) {
      case PaymentType.cash:
        map = {
          "image": Assets.images.cash.path,
          "title": context.localizations.cash,
        };
      case PaymentType.wallet:
        map = {
          "image": Assets.images.card.path,
          "title": context.localizations.wallet,
        };
      case PaymentType.visa:
        map = {
          "image": Assets.images.card.path,
          "title": context.localizations.visa,
        };
      case PaymentType.zainCash:
        map = {
          "image": Assets.images.card.path,
          "title": context.localizations.visa,
        };
      case PaymentType.fastPay:
        map = {
          "image": Assets.images.card.path,
          "title": context.localizations.visa,
        };
      case PaymentType.fib:
        map = {
          "image": Assets.images.card.path,
          "title": context.localizations.visa,
        };
    }
    return map;
  }
}
