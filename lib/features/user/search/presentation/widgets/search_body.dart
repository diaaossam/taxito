import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/extensions/sliver_padding.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_card_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../product/data/models/product_model.dart';
import 'empty_filter_design.dart';

class SearchBody extends StatelessWidget {
  final PagingController<int, ProductModel> pagingController;

  const SearchBody({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavouriteCubit>(),
      child: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {
          if (state is ToggleFavouriteSuccess) {
            AppConstant.showCustomSnakeBar(context, state.msg, true);
          }
          if (state is ToggleFavouriteFailure) {
            AppConstant.showCustomSnakeBar(context, state.msg, false);
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ).toSliver,
              SliverPadding(
                padding: screenPadding(),
                sliver: PagedSliverGrid<int, ProductModel>(
                  pagingController: pagingController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  builderDelegate: PagedChildBuilderDelegate(
                    noItemsFoundIndicatorBuilder: (context) =>
                        const EmptyFilterDesign(),
                    itemBuilder: (context, ProductModel item, index) =>
                        ProductCardGrid(
                      productModel: item,withExpandedText: true,
                      isLiked: item.isAddedToFavourite ?? false,
                      onTapped: (isLiked) {
                        item.isAddedToFavourite = isLiked;
                        context.read<FavouriteCubit>().toggleWishlist(
                              id: item.id ?? 0,
                              type: "product",
                            );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
