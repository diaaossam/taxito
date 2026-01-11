import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/response/orders.dart';
import 'comminucation_order.dart';

class OrderPersonsInfo extends StatelessWidget {
  final Orders orders;

  const OrderPersonsInfo({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          text: context.localizations.supplierDetails,
          fontWeight: FontWeight.bold,
        ),
        10.verticalSpace,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.colorScheme.onPrimary,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  orders.supplier?.profileImage ?? "",
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: orders.supplier?.name ?? "",
                      fontWeight: FontWeight.w600,
                    ),
                    6.verticalSpace,
                    AppText(
                      text: orders.supplier?.address ?? "",
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              ComminucationOrderWidget(phone: orders.supplier?.phone ?? ""),
            ],
          ),
        ),
        20.verticalSpace,
        AppText(
          text: context.localizations.userDetails,
          fontWeight: FontWeight.bold,
        ),
        10.verticalSpace,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.colorScheme.onPrimary,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(orders.user?.profileImage ?? ""),
              ),
              8.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: orders.user?.name ?? "",
                      fontWeight: FontWeight.w600,
                    ),
                    6.verticalSpace,
                    AppText(
                      text: orders.user?.address ?? "",
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              ComminucationOrderWidget(phone: orders.user?.phone ?? ""),
            ],
          ),
        ),
      ],
    );
  }
}
