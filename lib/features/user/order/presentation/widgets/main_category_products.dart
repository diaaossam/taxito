import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/product/presentation/cubit/product/product_cubit.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_card_grid.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_card_loading.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../core/utils/app_constant.dart';
import 'package:taxito/features/common/models/product_model.dart';
import '../../../product/presentation/cubit/favourite/favourite_cubit.dart';

class MainCategoryProducts extends StatelessWidget {
  final PagingController<int, ProductModel> pagingController;
  final String title;
  final VoidCallback? onTap;

  const MainCategoryProducts({
    super.key,
    required this.pagingController,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (pagingController.value.status == PagingStatus.noItemsFound) {
          return const Center();
        } else {
          return Container(
            decoration: BoxDecoration(color: context.colorScheme.surface),
            height: SizeConfig.bodyHeight * .37,
            margin: EdgeInsets.symmetric(vertical: 7.h),
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.bodyHeight * .01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: screenPadding(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: title,
                          textSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        AppText(
                          text: context.localizations.showMore,
                          textSize: 11,
                          color: context.colorScheme.tertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.bodyHeight * .01),
                Expanded(
                  child: BlocConsumer<FavouriteCubit, FavouriteState>(
                    listener: (context, state) {
                      if (state is ToggleFavouriteSuccess) {
                        AppConstant.showCustomSnakeBar(
                          context,
                          state.msg,
                          true,
                        );
                      }
                      if (state is ToggleFavouriteFailure) {
                        AppConstant.showCustomSnakeBar(
                          context,
                          state.msg,
                          false,
                        );
                      }
                    },
                    builder: (context, state) {
                      return PagedListView<int, ProductModel>(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        pagingController: pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<ProductModel>(
                              firstPageProgressIndicatorBuilder: (context) =>
                                  const ProductListLoading(),
                              itemBuilder: (context, item, index) =>
                                  ProductCardGrid(
                                    key: ValueKey(item.id),
                                    productModel: item,
                                    isLiked: item.isAddedToFavourite ?? false,
                                    onTapped: (p0) {
                                      item.isAddedToFavourite = p0;
                                      return context
                                          .read<FavouriteCubit>()
                                          .toggleWishlist(
                                            type: "product",
                                            id: item.id!,
                                          );
                                    },
                                  ),
                              noItemsFoundIndicatorBuilder: (context) =>
                                  const Center(),
                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
