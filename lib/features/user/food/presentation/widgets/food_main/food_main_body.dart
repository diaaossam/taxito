import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/product/presentation/pages/all_products_screen.dart';
import 'package:aslol/features/search/presentation/widgets/seach_ttf_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../order/data/models/product_params.dart';
import '../../../../order/presentation/widgets/main_category_products.dart';
import '../../../../product/presentation/cubit/product/product_cubit.dart';
import '../main_categories/main_category_design.dart';

class FoodMainBody extends StatefulWidget {
  const FoodMainBody({super.key});

  @override
  State<FoodMainBody> createState() => _FoodMainBodyState();
}

class _FoodMainBodyState extends State<FoodMainBody> {
  @override
  void initState() {
    _initProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final bloc = context.read<ProductCubit>();
        return RefreshIndicator(
          onRefresh: () async {
            bloc.mostSellingController.refresh();
            bloc.bestOffersController.refresh();
            bloc.recommendedController.refresh();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
                const SearchTextFormFieldDesign(),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                const MainCategoryDesign(),
                MainCategoryProducts(
                  title: context.localizations.mostSelling,
                  pagingController: bloc.mostSellingController,
                  onTap: () => context.navigateTo(AllProductsScreen(
                      title: context.localizations.mostSelling,
                      params:
                          const ProductParams(pageKey: 1, isMostSelling: 1))),
                ),
                MainCategoryProducts(
                  title: context.localizations.specialOffers,
                  pagingController: bloc.bestOffersController,
                  onTap: () => context.navigateTo(AllProductsScreen(
                      title: context.localizations.specialOffers,
                      params: const ProductParams(pageKey: 1, isFeatured: 1))),
                ),
                MainCategoryProducts(
                  title: context.localizations.recommended,
                  onTap: () => context.navigateTo(AllProductsScreen(
                      title: context.localizations.recommended,
                      params:
                          const ProductParams(pageKey: 1, isRecommended: 1))),
                  pagingController: bloc.recommendedController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _initProducts() {
    final bloc = context.read<ProductCubit>();
    bloc.mostSellingController.addPageRequestListener(
      (pageKey) => bloc.fetchPage(
          pageKey: pageKey,
          params: const ProductParams(pageKey: 1, isFeatured: 1),
          pagingController: bloc.mostSellingController),
    );
    bloc.bestOffersController.addPageRequestListener(
      (pageKey) => bloc.fetchPage(
          pageKey: pageKey,
          params: const ProductParams(pageKey: 1, isRecommended: 1),
          pagingController: bloc.bestOffersController),
    );
    bloc.recommendedController.addPageRequestListener(
      (pageKey) => bloc.fetchPage(
          pageKey: pageKey,
          params: const ProductParams(pageKey: 1, isMostSelling: 1),
          pagingController: bloc.recommendedController),
    );
  }
}
