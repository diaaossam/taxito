import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/product/data/models/favoutrite_response.dart';
import 'package:taxito/core/data/models/product_model.dart';
import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:taxito/features/user/supplier/presentation/widgets/supplier_product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../order/presentation/widgets/orders/my_orders_tab_bar.dart';
import '../../../../search/presentation/widgets/empty_filter_design.dart';
import '../../../../supplier/presentation/widgets/supplier_card_grid.dart';
import '../product_card_grid.dart';

class FavouriteBody extends StatefulWidget {
  const FavouriteBody({super.key});

  @override
  State<FavouriteBody> createState() => _FavouriteBodyState();
}

class _FavouriteBodyState extends State<FavouriteBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final PagingController<int, FavouriteResponse> pagingController =
      PagingController(firstPageKey: 1);
  bool isFilter = false;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    pagingController.addPageRequestListener(
      (pageKey) {
        if (!isFilter) {
          context.read<FavouriteCubit>().fetchPage(
              pageKey: pageKey, type: 1, pagingController: pagingController);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
            ),
            SliverPadding(
              padding: screenPadding(),
              sliver: SliverToBoxAdapter(
                child: TabBarDesign(
                  isScrollable: false,
                  onTap: (index) {
                    setState(() => isFilter = true);
                    pagingController.refresh();
                    context.read<FavouriteCubit>().fetchPage(
                        pageKey: 1,
                        type: index + 1,
                        pagingController: pagingController);
                    setState(() => isFilter = false);
                  },
                  tabController: tabController,
                  tabs: [
                    Tab(
                      text: context.localizations.products,
                    ),
                    Tab(
                      text: context.localizations.suppliers,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: screenPadding(),
              sliver: BlocConsumer<FavouriteCubit, FavouriteState>(
                listener: (context, state) {
                  if (state is ToggleFavouriteSuccess) {
                    AppConstant.showCustomSnakeBar(context, state.msg, true);
                  }
                  if (state is ToggleFavouriteFailure) {
                    AppConstant.showCustomSnakeBar(context, state.msg, false);
                  }
                },
                builder: (context, state) {
                  return PagedSliverGrid<int, FavouriteResponse>(
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate(noItemsFoundIndicatorBuilder: (context) =>
                            const EmptyFilterDesign(),
                        itemBuilder: (context, FavouriteResponse item, index) {
                          if (item.type == 1) {
                            return ProductCardGrid(
                              productModel: item.productModel!,
                              imageWidth: double.infinity,
                              isLiked: item.productModel?.isAddedToFavourite ??
                                  false,
                              onTapped: (p0) => context
                                  .read<FavouriteCubit>()
                                  .toggleWishlist(
                                      type: "product",
                                      id: item.productModel!.id!),
                            );
                          } else {
                            return SupplierCardGrid(
                              supplierModel: item.supplierModel!,
                              isLiked: item.supplierModel?.isAddedToFavourite ?? false,
                              onTapped: (p0) => context
                                  .read<FavouriteCubit>()
                                  .toggleWishlist(
                                  type: "supplier",
                                  id: item.supplierModel!.id!),
                            );
                          }
                        },
                      ),
                      gridDelegate: productDelegate(aspectRatio: 0.72));
                },
              ),
            )
          ],
        );
      },
    );
  }
}
