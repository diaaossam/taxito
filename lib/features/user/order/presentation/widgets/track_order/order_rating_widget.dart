import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/order/data/models/orders.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../pages/rating_screen.dart';

class OrderRatingWidget extends StatelessWidget {
  final Orders orders;

  const OrderRatingWidget({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRatingBar(
            context: context,
            type: "supplier",
            title: context.localizations.rateSeller,
            image: Assets.images.vendorTracking.path),
        SizedBox(
          height: SizeConfig.bodyHeight * .015,
        ),
        _buildRatingBar(
            context: context,
            type: "driver",
            title: context.localizations.rateDelivery,
            image: Assets.images.deliveryRating.path),
        SizedBox(
          height: SizeConfig.bodyHeight * .015,
        ),
        _buildRatingBar(
            context: context,
            type: "product",
            title: context.localizations.rateProduct,
            image: Assets.images.productRating.path),
      ],
    );
  }

  Widget _buildRatingBar(
      {required BuildContext context,
      required String type,
      required String title,
      required String image}) {
    return InkWell(
      onTap: () => context.navigateTo(RatingScreen(
        orders: orders,
        type: type,
        title: title,
      )),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * .04,
            vertical: SizeConfig.bodyHeight * .01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colorScheme.outline)),
        child: Row(
          children: [
            AppImage.asset(
              image,
              height: 45.h,
            ),
            10.horizontalSpace,
            Expanded(
                child: AppText(
              text: title,
              fontWeight: FontWeight.w600,
            )),
            AppImage.asset(Assets.icons.arrowForward)
          ],
        ),
      ),
    );
  }
}
