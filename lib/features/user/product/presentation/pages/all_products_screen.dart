import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/order/data/models/product_params.dart';
import 'package:taxito/features/user/search/presentation/widgets/filter_icon.dart';
import 'package:taxito/features/user/search/presentation/widgets/search_body.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/custom_sliver_app_bar.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import 'package:taxito/features/common/models/product_model.dart';
import '../cubit/product/product_cubit.dart';

class AllProductsScreen extends StatefulWidget {
  final String? title;
  final ProductParams? params;

  const AllProductsScreen({super.key, this.params, this.title});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final PagingController<int, ProductModel> productsController =
      PagingController(firstPageKey: 1);
  ProductParams params = const ProductParams(pageKey: 1);
  bool isFiltering = false;

  @override
  void initState() {
    final productBloc = context.read<ProductCubit>();
    if (widget.params != null) {
      params = widget.params!;
    }
    productsController.addPageRequestListener((pageKey) {
      if (!isFiltering) {
        productBloc.fetchPage(
          params: params,
          pageKey: pageKey,
          pagingController: productsController,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    productsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomSliverAppBar(
            expandedHeight: SizeConfig.bodyHeight * .13,
            showLeading: widget.params != null,
            title: widget.title ?? context.localizations.products,
            preferredSizeWidget: PreferredSize(
              preferredSize: Size(SizeConfig.screenWidth, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: SizeConfig.screenWidth * .04),
                  Expanded(
                    child: CustomTextFormField(
                      hintText: context.localizations.searchHint,
                      onChanged: (String? value) {
                        if (value!.isNotEmpty) {
                          setState(() {
                            params = params.copyWith(search: value);
                            isFiltering = true;
                          });
                          final productBloc = context.read<ProductCubit>();
                          productsController.refresh();
                          productBloc.fetchPage(
                            params: params,
                            pageKey: 1,
                            pagingController: productsController,
                          );
                          setState(() => isFiltering = false);
                        }
                      },
                      prefixIcon: AppImage.asset(Assets.icons.searchNormal),
                    ),
                  ),
                  SizedBox(width: SizeConfig.screenWidth * .03),
                  FilterIcon(
                    paramsCallback: (p0) {
                      setState(() {
                        params = p0;
                        isFiltering = true;
                      });
                      final productBloc = context.read<ProductCubit>();
                      productsController.refresh();
                      productBloc.fetchPage(
                        params: p0,
                        pageKey: 1,
                        pagingController: productsController,
                      );
                      setState(() => isFiltering = false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
        body: SearchBody(pagingController: productsController),
      ),
    );
  }
}
