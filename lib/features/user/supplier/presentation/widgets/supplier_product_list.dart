import 'package:taxito/features/user/order/data/models/product_params.dart';
import 'package:taxito/features/common/models/product_model.dart';
import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:taxito/features/user/product/presentation/cubit/product/product_cubit.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_card_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SupplierProductList extends StatefulWidget {
  final num supplierId;

  const SupplierProductList({super.key, required this.supplierId});

  @override
  State<SupplierProductList> createState() => _SupplierProductListState();
}

class _SupplierProductListState extends State<SupplierProductList> {
  final PagingController<int, ProductModel> pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      context.read<ProductCubit>().fetchPage(
        params: ProductParams(pageKey: pageKey, supplierId: widget.supplierId),
        pagingController: pagingController,
        pageKey: pageKey,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return PagedSliverGrid<int, ProductModel>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => ProductCardGrid(
              productModel: item,
              supplierId: widget.supplierId,
              isLiked: item.isAddedToFavourite ?? false,
              onTapped: (p0) => context.read<FavouriteCubit>().toggleWishlist(
                type: "product",
                id: item.id!,
              ),
            ),
          ),
          gridDelegate: productDelegate(),
        );
      },
    );
  }
}

SliverGridDelegate productDelegate({double? aspectRatio}) =>
    SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: aspectRatio ?? 0.75,
    );
