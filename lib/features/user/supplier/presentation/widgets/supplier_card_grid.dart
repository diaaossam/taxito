import 'package:animations/animations.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_details/like_button.dart';
import 'package:taxito/features/user/supplier/data/models/response/supplier_model.dart';
import 'package:taxito/features/user/supplier/presentation/pages/supplier_details_screen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupplierCardGrid extends StatelessWidget {
  final SupplierModel supplierModel;
  final double? imageHeight, imageWidth;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final num? supplierId;
  final bool isLiked;
  final dynamic Function(bool) onTapped;

  const SupplierCardGrid(
      {super.key,
      required this.supplierModel,
      this.imageHeight,
      this.imageWidth,
      this.onTap,
      this.margin,
      this.supplierId,
      required this.isLiked,
      required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) => Container(
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppImage.network(
                    height: imageHeight ?? SizeConfig.bodyHeight * .18,
                    width: imageWidth ?? SizeConfig.screenWidth * .38,
                    remoteImage: supplierModel.logo,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.directional(
                  end: 5,
                  top: 5,
                  textDirection: TextDirection.ltr,
                  child: LikeButtonDesign(
                    onTapped: onTapped,
                    isLiked: isLiked,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            AppText(
              text: supplierModel.name ?? "",
              textSize: 12,
              maxLines: 2,
              fontWeight: FontWeight.w500,
            ),
            10.verticalSpace,
            AppText(
              text: "${supplierModel.province?.title} - ${supplierModel.region?.title}",
              textSize: 11,
              maxLines: 2,
              fontWeight: FontWeight.w400,
              color: context.colorScheme.shadow,
            ),
          ],
        ),
      ),
      openBuilder: (context, action) => SupplierDetailsScreen(
        supplierModel: supplierModel,
      ),
    );
  }
}
