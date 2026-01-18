import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/sliver_padding.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_details/like_button.dart';
import 'package:taxito/features/user/supplier/presentation/cubit/supplier_details/supplier_details_bloc.dart';
import 'package:taxito/features/user/supplier/presentation/widgets/details/supplier_category_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/back_widget.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../../../../widgets/info_design_item.dart';
import '../../../data/models/response/supplier_model.dart';
import '../supplier_product_grid.dart';
import 'supplier_cover_design.dart';

class SupplierDetailsBody extends StatelessWidget {
  final SupplierModel supplierModel;
  final Function(bool) onLikeToggeled;

  const SupplierDetailsBody({
    super.key,
    required this.supplierModel,
    required this.onLikeToggeled,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            SupplierCoverDesign(supplierModel: supplierModel),
            Positioned(
              top: SizeConfig.bodyHeight * .1,
              width: SizeConfig.screenWidth * .95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackArrowWidget(),
                  LikeButtonDesign(
                    key: ValueKey("supplier_like_button_${supplierModel.id}"),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        offset: const Offset(2, 2),
                        blurRadius: 5,
                        color: const Color(0xff2E3651).withValues(alpha: 0.15),
                      ),
                    ],
                    onTapped: onLikeToggeled,
                    isLiked: supplierModel.isAddedToFavourite ?? false,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            color: context.colorScheme.surface,
          ),
          padding: screenPadding(),
          margin: EdgeInsets.only(top: SizeConfig.bodyHeight * .32),
          child: CustomScrollView(
            slivers: [
              SizedBox(height: SizeConfig.bodyHeight * .02).toSliver,
              SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.bodyHeight * 0.12,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppText(
                            text: supplierModel.name ?? "",
                            textSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: SizeConfig.bodyHeight * .01),
                          AppText.hint(
                            text: supplierModel.about ?? "",
                            fontWeight: FontWeight.w500,
                            maxLines: 3,
                          ),
                          SizedBox(height: SizeConfig.bodyHeight * .01),
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
              SizedBox(height: SizeConfig.bodyHeight * .02).toSliver,
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * .08,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoDesignItem(
                        icon: Assets.icons.clock,
                        title:
                            "${supplierModel.duration} ${context.localizations.minute}",
                      ),
                      15.horizontalSpace,
                      InfoDesignItem(
                        icon: Assets.icons.motorbike,
                        title:
                            "${supplierModel.distance} ${context.localizations.minute}",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02).toSliver,
              const SupplierCategoryDesign(),
              SizedBox(height: SizeConfig.bodyHeight * .02).toSliver,
              BlocBuilder<SupplierDetailsBloc, SupplierDetailsState>(
                builder: (context, state) {
                  if (context.read<SupplierDetailsBloc>().model != null) {
                    return SupplierProductGrid(
                      model: supplierModel,
                      category: context.read<SupplierDetailsBloc>().model!,
                    );
                  } else {
                    return const SizedBox.shrink().toSliver;
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
