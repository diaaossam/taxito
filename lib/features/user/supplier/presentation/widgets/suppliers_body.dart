import 'dart:async';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/sliver_padding.dart';
import 'package:taxito/features/user/main/data/models/banners_model.dart';
import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:taxito/features/user/supplier/data/models/requests/suppliers_params.dart';
import 'package:taxito/features/user/supplier/data/models/response/supplier_model.dart';
import 'package:taxito/features/user/supplier/presentation/cubit/supplier_cubit.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../search/presentation/widgets/empty_filter_design.dart';
import 'supplier_card_list.dart';
import 'supplier_filter_icon.dart';

class SuppliersBody extends StatefulWidget {
  final BannersModel bannersModel;

  const SuppliersBody({super.key, required this.bannersModel});

  @override
  State<SuppliersBody> createState() => _SuppliersBodyState();
}

class _SuppliersBodyState extends State<SuppliersBody> {
  SuppliersParams params = SuppliersParams(pageKey: 1);
  bool isFiltering = false;
  Timer? _debounce;

  @override
  void initState() {
    final bloc = context.read<SupplierCubit>();
    params = params.copyWith(supplierCategories: [widget.bannersModel.id ?? 0]);
    bloc.pagingController.addPageRequestListener((pageKey) {
      params = params.copyWith(pageKey: pageKey);
      if (!isFiltering) {
        bloc.fetchPage(params: params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    context.read<SupplierCubit>().pagingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupplierCubit, SupplierState>(
      builder: (context, state) {
        final bloc = context.read<SupplierCubit>();
        return Scaffold(
          appBar: CustomAppBar(
            showBackButton: false,
            leadingWidth: 0,
            titleWidget: CustomTextFormField(
              hintText: context.localizations.searchForSuppliers,
              onChanged: (String? value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 700), () {
                  setState(() {
                    params = params.copyWith(search: value, pageKey: 1);
                    isFiltering = true;
                  });
                  bloc.pagingController.refresh();
                  bloc.fetchPage(params: params);
                  setState(() => isFiltering = false);
                });
              },
              prefixIcon: AppImage.asset(Assets.icons.searchNormal),
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SizedBox(height: SizeConfig.bodyHeight * .02).toSliver,
              BlocConsumer<FavouriteCubit, FavouriteState>(
                listener: (context, state) {
                  if (state is ToggleFavouriteSuccess) {
                    AppConstant.showCustomSnakeBar(context, state.msg, true);
                  }
                  if (state is ToggleFavouriteFailure) {
                    AppConstant.showCustomSnakeBar(context, state.msg, false);
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<SupplierCubit, SupplierState>(
                    builder: (context, state) {
                      final bloc = context.read<SupplierCubit>();
                      return SliverPadding(
                        padding: screenPadding(),
                        sliver: PagedSliverList<int, SupplierModel>(
                          pagingController: bloc.pagingController,
                          builderDelegate: PagedChildBuilderDelegate(
                            noItemsFoundIndicatorBuilder: (context) =>
                                const EmptyFilterDesign(),
                            itemBuilder: (context, SupplierModel item, index) =>
                                SupplierCardList(
                                  isLiked:
                                      item.isAddedToFavourite == true,
                                  supplierModel: item,
                                  onTapped: (p0) async {
                                    item.isAddedToFavourite = p0;
                                    return context
                                        .read<FavouriteCubit>()
                                        .toggleWishlist(
                                          type: "supplier",
                                          id: item.id!,
                                        );
                                  },
                                ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
