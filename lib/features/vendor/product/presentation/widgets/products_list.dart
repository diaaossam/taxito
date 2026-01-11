import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/sliver_padding.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/vendor/product/presentation/widgets/product_item.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../attributes/presentation/widgets/attribute_actions_modal.dart';
import '../../../attributes/presentation/widgets/delete_confirmation_modal.dart';
import '../../../order/data/models/response/product_model.dart';
import '../cubit/product_cubit.dart';
import '../pages/add_product_screen.dart';

class ProductsList extends StatelessWidget {
  final PagingController<int, ProductModel> pagingController;

  const ProductsList({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductCubit>(),
      child: RefreshIndicator(
        onRefresh: () async => pagingController.refresh(),
        child: CustomScrollView(
          slivers: [
            SizedBox(height: SizeConfig.bodyHeight * .02).toSliver,
            SliverPadding(
              padding: screenPadding(),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: AppText(
                        text: context.localizations.allProducts,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () => context.navigateTo(
                        const AddProductScreen(),
                        callback: (p0) {
                          pagingController.refresh();
                        },
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: context.colorScheme.primary,
                          ),
                        ),
                        child: Row(
                          children: [
                            AppImage.asset(
                              Assets.icons.add,
                              color: context.colorScheme.primary,
                            ),
                            8.horizontalSpace,
                            AppText(
                              text: context.localizations.addProduct,
                              fontWeight: FontWeight.w500,
                              color: context.colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02).toSliver,
            BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {
                if (state is ProductActionFailure) {
                  AppConstant.showCustomSnakeBar(context, state.msg, false);
                }
              },
              builder: (context, state) {
                return PagedSliverList(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ProductModel>(
                    itemBuilder: (context, ProductModel item, index) {
                      return ProductItem(
                        onTapAction: () => _showProductActions(
                          model: item,
                          cubit: context.read<ProductCubit>(),
                          context: context,
                        ),
                        productModel: item,
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) => Opacity(
                      opacity: 0.4,
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.bodyHeight * .2),
                          AppImage.asset(Assets.icons.product, size: 100),
                          SizedBox(height: SizeConfig.bodyHeight * .03),
                          AppText(
                            text: context.localizations.noProductFound,
                            textSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showProductActions({
    required ProductModel model,
    required ProductCubit cubit,
    required BuildContext context,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => AttributeActionsModal(
        titleDelete: context.localizations.deleteProduct,
        titleUpdate: context.localizations.editProduct,
        onEdit: () => context.navigateTo(AddProductScreen(productModel: model)),
        onDelete: () => _showDeleteConfirmation(
          cubit: cubit,
          model: model,
          context: context,
        ),
      ),
    );
  }

  void _showDeleteConfirmation({
    required ProductModel model,
    required ProductCubit cubit,
    required BuildContext context,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => DeleteConfirmationModal(
        onConfirm: () {
          cubit.deleteProduct(id: model.id ?? 0);
          pagingController.refresh();
        },
      ),
    );
  }
}
