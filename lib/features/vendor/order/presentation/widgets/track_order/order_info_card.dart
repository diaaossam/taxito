import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import 'package:taxito/features/common/models/orders.dart';
import '../../../order_helper.dart';

class OrderInfoCard extends StatelessWidget {
  final Orders orders;

  const OrderInfoCard({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: screenPadding(),
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.bodyHeight * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppText(
                    text: "${context.localizations.orderNumber} :",
                    fontWeight: FontWeight.w600,
                    textSize: 12,
                  ),
                  6.horizontalSpace,
                  AppText(
                    text: "#${orders.orderNumber}",
                    fontWeight: FontWeight.w600,
                    textSize: 12,
                    color: context.colorScheme.primary,
                  ),
                ],
              ),
              AppText(
                text: handleOrderTypeToString(code: orders.status!),
                color: context.colorScheme.tertiary,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text:
                    "${orders.finalPrice.toString()} ${context.localizations.iqd}",
                textSize: 13,
                fontWeight: FontWeight.w700,
              ),
              AppText(
                color: context.colorScheme.shadow,
                textSize: 12,
                text: OrderHelper().formatDateTime(
                  orders.createdAt ?? DateTime.now(),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
        ],
      ),
    );
  }
}
