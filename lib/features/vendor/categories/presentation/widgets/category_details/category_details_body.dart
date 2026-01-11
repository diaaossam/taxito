import 'dart:async';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/custom_app_bar.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../../../captain/app/data/models/generic_model.dart';
import '../../../../product/data/models/request/product_params.dart';
import '../../../../product/presentation/widgets/products_list.dart';
import '../../cubit/details/category_details_cubit.dart';

class CategoryDetailsBody extends StatefulWidget {
  final GenericModel? genericModel;

  const CategoryDetailsBody({super.key, this.genericModel});

  @override
  State<CategoryDetailsBody> createState() => _CategoryDetailsBodyState();
}

class _CategoryDetailsBodyState extends State<CategoryDetailsBody> {
  ProductParams params = const ProductParams(pageKey: 1);
  bool isFiltering = false;
  Timer? _debounce;

  @override
  void initState() {
    final bloc = context.read<CategoryDetailsCubit>();
    if (widget.genericModel != null) {
      params = params.copyWith(
        pageKey: 1,
        productCategories: [widget.genericModel!.id!],
      );
    }
    bloc.pagingController.addPageRequestListener((pageKey) {
      if (!isFiltering) {
        params = params.copyWith(pageKey: pageKey);
        bloc.fetchPage(params: params, pageKey: pageKey);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: false,
        leadingWidth: 0,
        titleWidget: CustomTextFormField(
          hintText: context.localizations.searchHint,
          onChanged: _handleSearch,
          prefixIcon: AppImage.asset(Assets.icons.searchNormal),
        ),
      ),
      body: ProductsList(
        pagingController: context.read<CategoryDetailsCubit>().pagingController,
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _handleSearch(String? value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      setState(() {
        params = params.copyWith(search: value, pageKey: 1);
        isFiltering = true;
      });
      final bloc = context.read<CategoryDetailsCubit>();
      bloc.pagingController.refresh();
      bloc.fetchPage(pageKey: 1, params: params);
      setState(() => isFiltering = false);
    });
  }
}
