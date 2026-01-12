import 'dart:async';

import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/order/data/models/product_params.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import 'package:taxito/core/data/models/product_model.dart';
import '../../../product/presentation/cubit/product/product_cubit.dart';
import '../widgets/filter_icon.dart';
import '../widgets/search_body.dart';

class SearchScreen extends StatefulWidget {
  final ProductParams? params;

  const SearchScreen({super.key, this.params});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ProductParams params = const ProductParams(pageKey: 1);
  final PagingController<int, ProductModel> productsController =
      PagingController(firstPageKey: 1);
  bool isFiltering = false;
  Timer? _debounce;

  @override
  void initState() {
    if (widget.params != null) {
      params = widget.params!;
    }
    final productBloc = context.read<ProductCubit>();
    productsController.addPageRequestListener((pageKey) {
      if (!isFiltering) {
        params = params.copyWith(pageKey: pageKey);
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
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: CustomTextFormField(
          hintText: context.localizations.searchHint,
          onChanged: (String? value) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 700), () {
              setState(() {
                params = params.copyWith(search: value, pageKey: 1);
                isFiltering = true;
              });
              final productBloc = context.read<ProductCubit>();
              productsController.refresh();
              productBloc.fetchPage(
                pageKey: 1,
                params: params,
                pagingController: productsController,
              );
              setState(() => isFiltering = false);
            });
          },
          prefixIcon: AppImage.asset(Assets.icons.searchNormal),
        ),
        actions: [
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
      body: SearchBody(pagingController: productsController),
    );
  }
}
