import 'package:animations/animations.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/product/presentation/widgets/product_details/like_button.dart';
import 'package:aslol/features/supplier/data/models/response/supplier_model.dart';
import 'package:aslol/features/supplier/presentation/pages/supplier_details_screen.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/info_design_item.dart';

class SupplierCardList extends StatelessWidget {
  final SupplierModel supplierModel;
  final VoidCallback? onTap;
  final Function(bool) onTapped;
  final bool isLiked;

  const SupplierCardList({
    super.key,
    required this.supplierModel,
    this.onTap,
    required this.onTapped,
    required this.isLiked,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      openElevation: 0,
      closedBuilder: (context, action) => Container(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.bodyHeight * .02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.bodyHeight * 0.16,
              width: SizeConfig.bodyHeight * .15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AppImage.network(
                  remoteImage: supplierModel.logo,
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
                          text: supplierModel.name ?? "",
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
                                color: const Color(0xff2E3651)
                                    .withValues(alpha: 0.15))
                          ],
                          onTapped: onTapped,
                          isLiked: supplierModel.isAddedToFavourite ?? false)
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      InfoDesignItem(
                        icon: Assets.icons.clock,
                        title: "${supplierModel.duration} ${context.localizations.minute}",
                      ),
                      15.horizontalSpace,
                      InfoDesignItem(
                        icon: Assets.icons.motorbike,
                        title:
                            "${supplierModel.distance} ${context.localizations.minute}",
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  InfoDesignItem(
                    icon: Assets.icons.star,
                    title:
                        "${supplierModel.reviewsAverage} (${supplierModel.reviewsCount})",
                  ),
                ],
              ),
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
