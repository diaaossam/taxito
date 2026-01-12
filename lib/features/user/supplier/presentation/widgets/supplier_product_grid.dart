import 'package:taxito/features/user/order/data/models/product_params.dart';
import 'package:taxito/features/user/product/data/models/product_model.dart';
import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:taxito/features/user/product/presentation/cubit/product/product_cubit.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_card_grid.dart';
import 'package:taxito/features/user/supplier/data/models/response/supplier_model.dart';
import 'package:taxito/features/user/supplier/presentation/cubit/supplier_details/supplier_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/utils/app_constant.dart';
import '../../../../captain/app/data/models/generic_model.dart';

class SupplierProductGrid extends StatefulWidget {
  final SupplierModel model;
  final GenericModel category;

  const SupplierProductGrid(
      {super.key, required this.model, required this.category});

  @override
  State<SupplierProductGrid> createState() => _SupplierProductGridState();
}

class _SupplierProductGridState extends State<SupplierProductGrid> {
  ProductParams? params;
  bool isFiltered = false;

  final PagingController<int, ProductModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener(
      (pageKey) {
        if (!isFiltered) {
          context.read<ProductCubit>().fetchPage(
              params: params ??
                  ProductParams(
                      pageKey: pageKey,
                      supplierId: widget.model.id,
                      productCategoryId: widget.category.id),
              pagingController: pagingController,
              pageKey: pageKey);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupplierDetailsBloc, SupplierDetailsState>(
      listener: (context, state) {
        if (state is SelectCategoryState) {
          setState(() {
            isFiltered = true;
            params = ProductParams(
                pageKey: 1,
                supplierId: widget.model.id,
                productCategoryId: state.model.id);
          });
          context.read<ProductCubit>().fetchPage(
              params: params!, pagingController: pagingController, pageKey: 1);
          pagingController.refresh();
          setState(() => isFiltered = false);
        }
      },
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
          return BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              return PagedSliverGrid<int, ProductModel>(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) => ProductCardGrid(
                      productModel: item,
                      supplierId: widget.model.id,
                      isLiked: item.isAddedToFavourite ?? false,
                      onReload: () => pagingController.refresh(),
                      onTapped: (p0) {
                        item.isAddedToFavourite = p0;

                        return context
                          .read<FavouriteCubit>()
                          .toggleWishlist(type: "product", id: item.id!);
                      },
                    ),
                  ),
                  gridDelegate: productDelegate());
            },
          );
        },
      ),
    );
  }
}

SliverGridDelegate productDelegate({double? aspectRatio}) =>
     SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: aspectRatio ?? 0.75);
