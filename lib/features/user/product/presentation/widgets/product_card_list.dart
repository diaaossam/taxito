import 'package:animations/animations.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_details/like_button.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/app_text.dart';
import '../../data/models/product_model.dart';
import '../pages/product_details.dart';

class ProductCardList extends StatelessWidget {
  final ProductModel productModel;
  final double? imageHeight, imageWidth;
  final VoidCallback? onTap;
  final Widget? child;
  final EdgeInsetsGeometry? margin;

  const ProductCardList({
    super.key,
    required this.productModel,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    this.child,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      openElevation: 0,
      closedBuilder: (context, action) => Container(
        margin: margin,
        padding: EdgeInsets.symmetric(vertical: SizeConfig.bodyHeight * .02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.bodyHeight * 0.15,
              width: SizeConfig.bodyHeight * .15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AppImage.network(
                  remoteImage: productModel.images?.first.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: productModel.title ?? "",
                          textSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      10.horizontalSpace,
                      LikeButtonDesign(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            offset: const Offset(2, 2),
                            blurRadius: 5,
                            color: const Color(
                              0xff2E3651,
                            ).withValues(alpha: 0.15),
                          ),
                        ],
                        onTapped: (p0) {},
                        isLiked: productModel.isAddedToFavourite ?? false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      openBuilder: (context, action) =>
          ProductDetailsScreen(productModel: productModel),
    );
  }
}
