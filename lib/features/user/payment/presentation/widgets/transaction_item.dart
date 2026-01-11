import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/order/order_helper.dart';
import 'package:aslol/features/payment/data/models/transaction_model.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transactionModel;

  const TransactionItem({super.key, required this.transactionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: context.colorScheme.outline)),
      child: Row(
        children: [
          AppImage.asset(
            Assets.images.card.path,
            height: 50.h,
            width: 50.h,
          ),
          10.horizontalSpace,
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: transactionModel.type.toString(),
                textSize: 13,
                fontWeight: FontWeight.bold,
              ),
              10.verticalSpace,
              AppText(text: transactionModel.description.toString()),
            ],
          )),
          10.horizontalSpace,
          AppText(
              fontWeight: FontWeight.w600,
              textSize: 14,
              color: context.colorScheme.tertiary,
              text: "+ ${formatPrice(
                price: transactionModel.amount.toString(),
              )}"),
        ],
      ),
    );
  }
}
