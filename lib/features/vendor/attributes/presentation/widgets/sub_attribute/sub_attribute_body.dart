import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/vendor/attributes/presentation/widgets/sub_attribute/sub_attribute_item.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import 'package:taxito/core/data/models/product_model.dart';
import '../../../../product/data/models/request/add_product_params.dart';
import '../../../../product/presentation/cubit/product_cubit.dart';
import '../../../data/models/attribute_model.dart';
import '../../../data/models/sub_attribute_value_model.dart';
import '../../cubit/sub_attribute/sub_attributes_cubit.dart';

class SubAttributeBody extends StatefulWidget {
  final List<num> selectedAttributes;
  final AddProductParams params;
  final ProductModel? productModel;

  const SubAttributeBody({
    super.key,
    required this.selectedAttributes,
    required this.params,
    this.productModel,
  });

  @override
  State<SubAttributeBody> createState() => _SubAttributeBodyState();
}

class _SubAttributeBodyState extends State<SubAttributeBody> {
  Map<num, List<SubAttributeValueModel>> _attributeValues = {};

  @override
  void initState() {
    final bloc = context.read<SubAttributesCubit>();
    bloc.pagingController.addPageRequestListener(
      (pageKey) => bloc.fetchPage(pageKey),
    );
    super.initState();
  }

  void _onAttributeValuesChanged(
    num attributeId,
    List<SubAttributeValueModel> values,
  ) => setState(() => _attributeValues[attributeId] = values);

  void _submitProductWithAttributes() async {
    List<ProductAttribute> attributes = [];

    _attributeValues.forEach((attributeId, values) {
      List<ProductAttributeOption> options = values.map((value) {
        File? imageFile;
        if (value.imagePath != null && value.imagePath!.isNotEmpty) {
          imageFile = File(value.imagePath!);
          Logger().i(
            'Attribute option image: ${value.imagePath}, exists: ${imageFile.existsSync()}, size: ${imageFile.existsSync() ? imageFile.lengthSync() : 0}',
          );
        }

        return ProductAttributeOption(
          titleAr: value.nameAr ?? "",
          titleEn: value.nameEn ?? '',
          price: value.price?.toString() ?? '0',
          oldPrice: null,
          image: imageFile,
          colorHex: value.color,
        );
      }).toList();

      attributes.add(
        ProductAttribute(id: attributeId.toInt(), options: options),
      );
    });

    // Create new params with attributes using copyWith
    final updatedParams = widget.params.copyWith(attributes: attributes);

    // Submit the product with attributes
    context.read<ProductCubit>().addProduct(params: updatedParams);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductActionSuccess) {
          AppConstant.showCustomSnakeBar(context, state.msg, false);
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is ProductActionFailure) {
          AppConstant.showCustomSnakeBar(context, state.msg, false);
        }
      },
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                PagedSliverList<int, AttributeModel>(
                  pagingController: context
                      .read<SubAttributesCubit>()
                      .pagingController,
                  builderDelegate: PagedChildBuilderDelegate<AttributeModel>(
                    itemBuilder: (context, attribute, index) =>
                        SubAttributeItem(
                          key: ValueKey('sub_attribute_${attribute.id}'),
                          model: attribute,
                          productModel: widget.productModel,
                          onValuesChanged: (values) =>
                              _onAttributeValuesChanged(attribute.id!, values),
                        ),
                    noItemsFoundIndicatorBuilder: (context) => Opacity(
                      opacity: 0.4,
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.bodyHeight * .2),
                          AppImage.asset(Assets.icons.category2, size: 100),
                          SizedBox(height: SizeConfig.bodyHeight * .03),
                          AppText(
                            text: context.localizations.noAttributesFound,
                            textSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.bodyHeight * 0.04),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * .03,
            ),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return CustomButton(
                  text: context.localizations.addProduct,
                  press: state is ProductActionLoading
                      ? () {}
                      : _submitProductWithAttributes,
                  width: double.infinity,
                  height: 50.h,
                  isLoading: state is ProductActionLoading,
                );
              },
            ),
          ),
          SizedBox(height: SizeConfig.bodyHeight * 0.04),
        ],
      ),
    );
  }
}
