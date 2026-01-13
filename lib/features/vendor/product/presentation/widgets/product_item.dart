import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:taxito/core/extensions/color_extensions.dart';

import '../../../main/presentation/pages/statics_info_design.dart';
import 'package:taxito/features/common/models/product_model.dart';
import '../pages/reviews_screen.dart';

class ProductItem extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback onTapAction;

  const ProductItem({
    super.key,
    required this.productModel,
    required this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    final int filledStars = ((double.tryParse(productModel.reviewsAvg ?? '0') ?? 0))
        .clamp(0, 5)
        .round();
    final String imageUrl =
        productModel.image?.url ??
        (productModel.images?.isNotEmpty == true
            ? (productModel.images?.first.url ?? '')
            : '');
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: AppImage.network(
                  width: 65.w,
                  height: 65.w,
                  fit: BoxFit.cover,
                  remoteImage: imageUrl,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: productModel.title ?? '',
                            fontWeight: FontWeight.w500,
                            textSize: 11,
                          ),
                        ),
                        10.horizontalSpace,
                        InkWell(
                          onTap: onTapAction,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colorScheme.shadow.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                            child: const Icon(Icons.more_horiz),
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        AppText(
                          text:
                              '(${(productModel.reviewsCount ?? 0).toString()})',
                          color: Colors.grey,
                          textSize: 11,
                        ),
                        6.horizontalSpace,
                        ...List.generate(5, (index) {
                          final bool isFilled = index < filledStars;
                          return Padding(
                            padding: EdgeInsets.only(right: 3.w),
                            child: Icon(
                              isFilled ? Icons.star : Icons.star_border,
                              size: 16.sp,
                              color: isFilled ? Colors.orange : Colors.grey,
                            ),
                          );
                        }),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        AppText(
                          text:
                              "${formatPrice(price: productModel.price.toString())} ${context.localizations.iqd}",
                          textSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        10.horizontalSpace,
                        if (productModel.oldPrice != null &&
                            productModel.oldPrice != 0) ...{
                          AppText(
                            text:
                                "${formatPrice(price: productModel.oldPrice.toString())} ${context.localizations.iqd}",
                            color: context.colorScheme.shadow,
                            textSize: 11,
                            textDecoration: TextDecoration.lineThrough,
                          ),
                          10.horizontalSpace,
                        },
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Center(
            child: InkWell(
              onTap: () =>
                  context.navigateTo(ReviewsScreen(productModel: productModel)),
              child: AppText(
                text: context.localizations.showRating,
                color: Colors.orange.shade700,
                fontWeight: FontWeight.w600,
                textSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
