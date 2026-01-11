import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/notifications/data/models/notification_model.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel model;

  const NotificationItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: model.isRead == false ? context.colorScheme.onPrimary : null),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              model.icon ??
                  "https://cdn.wedevs.com/uploads/2021/04/Limited-Time-Offer_-How-To-Write-a-Discount-Offer-For-Limited-Time-Only.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                Assets.images.logoCirclure.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: model.description.toString(),
                  maxLines: 2,
                  textSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 5),
                AppText(
                  text: model.readAtForHumans.toString(),
                  maxLines: 3,
                  textSize: 9,
                  color: context.colorScheme.shadow,
                ),
              ],
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth * .03),
        ],
      ),
    );
  }
}
