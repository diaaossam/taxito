import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/vendor/product/presentation/cubit/product_cubit.dart';
import 'package:taxito/features/vendor/product/presentation/widgets/add_product/vehicle_image/images_list_design.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../../../widgets/app_multi_select.dart';
import '../../../../attributes/presentation/cubit/attributes_cubit.dart';
import '../../../../attributes/presentation/pages/sub_attribute_screen.dart';
import '../../../../categories/presentation/cubit/categories_cubit.dart';
import 'package:taxito/features/common/models/product_model.dart';
import '../../../data/models/request/add_product_params.dart';
import 'attribute_item_widget.dart';

class AddProductBody extends StatefulWidget {
  final ProductModel? productModel;

  const AddProductBody({super.key, this.productModel});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  List<String> images = [];
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Set<num> selectedAttributes = {};
  Map<num, List<ProductAttributeOption>> attributeOptions = {};
  bool _isAva = true;
  ProductModel? productModel;

  @override
  void initState() {
    super.initState();
    if (widget.productModel != null) {
      _initializeWithProductData();
    }
  }

  void _initializeWithProductData() {
    final product = widget.productModel!;
    _isAva = product.isAvailable == 1;

    if (product.images != null && product.images!.isNotEmpty) {
      context.read<ProductCubit>().getProduct(id: product.id!, isInit: true);
      images = product.images!.map((img) => img.url ?? '').toList();
    }
  }

  void _toggleAttribute(num attributeId) {
    setState(() {
      if (selectedAttributes.contains(attributeId)) {
        selectedAttributes.remove(attributeId);
        attributeOptions.remove(attributeId);
      } else {
        selectedAttributes.add(attributeId);
      }
    });
  }

  void _submitProduct() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      final params = AddProductParams(
        title: formData['name'],
        description: formData['description'],
        price: formData['price'],
        oldPrice: formData['old_price'],
        images: images,
        isAvailable: _isAva ? "1" : "0",
        productCategories: formData['category']?.cast<int>(),
      );

      if (selectedAttributes.isNotEmpty) {
        context.navigateTo(
          SubAttributeScreen(
            productModel: productModel ?? widget.productModel,
            selectedAttributes: selectedAttributes.toList(),
            params: params,
          ),
        );
      } else {
        context.read<ProductCubit>().addProduct(params: params);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductActionSuccess) {
          if (state.productModel != null) {
            setState(() => productModel = state.productModel);
          } else {
            AppConstant.showCustomSnakeBar(context, state.msg, false);
          }
        } else if (state is ProductActionFailure) {
          AppConstant.showCustomSnakeBar(context, state.msg, false);
        }
      },
      child: Padding(
        padding: screenPadding(),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.bodyHeight * .02),
              AppText(
                text: context.localizations.productImage,
                fontWeight: FontWeight.bold,
                textSize: 14,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              AppText(text: context.localizations.productImage1),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              ProductImagePickerWidget(
                images: (imagePaths) => setState(() => images = imagePaths),
                imagesListFromApi: images,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomTextFormField(
                name: "name",
                hintText: context.localizations.productNameHint,
                title: context.localizations.productName,
                validator: FormBuilderValidators.required(),
                initialValue: widget.productModel?.title,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomTextFormField(
                name: "description",
                initialValue: widget.productModel?.description,
                hintText: context.localizations.productDescriptionHint,
                title: context.localizations.productDescription,
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomTextFormField(
                name: "price",
                initialValue: widget.productModel?.price?.toString(),
                title: context.localizations.productPrice1,
                hintText: "50 ${context.localizations.iqd}",
                validator: FormBuilderValidators.required(),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomTextFormField(
                name: "old_price",
                title: context.localizations.oldProductPrice,
                initialValue: widget.productModel?.oldPrice?.toString(),
                hintText: "50 ${context.localizations.iqd}",
                validator: FormBuilderValidators.required(),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  final bloc = context.read<CategoriesCubit>();
                  return FormBuilderField<List<int>>(
                    name: "category",
                    validator: FormBuilderValidators.required(
                      errorText: context.localizations.validation,
                    ),
                    initialValue: widget.productModel?.categories
                        ?.map((e) => e.id!)
                        .toList(),
                    builder: (FormFieldState<List<int>?> field) {
                      return MultiSelectDropdown(
                        initialSelectedItems: widget.productModel?.categories,
                        label: context.localizations.activityType,
                        items: bloc.categories,
                        onChanged: (selectedItems) {
                          field.didChange(
                            selectedItems.map((e) => e.id!).toList(),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              AppText(
                text: context.localizations.addiontion,
                fontWeight: FontWeight.w500,
                textSize: 14,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              BlocBuilder<AttributesCubit, AttributesState>(
                builder: (context, state) {
                  final bloc = context.read<AttributesCubit>();
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final attribute = bloc.attributes[index];

                        if (state is AttributesActionLoading) {
                          return const LoadingWidget();
                        }
                        if (productModel?.attributes != null) {
                          selectedAttributes =
                              productModel?.attributes
                                  ?.map((attr) => attr.attributeId!)
                                  .toSet() ??
                              {};
                        }

                        return AttributeItemWidget(
                          attribute: attribute,
                          isSelected: selectedAttributes.contains(attribute.id),
                          onTap: () => _toggleAttribute(attribute.id!),
                        );
                      },
                      itemCount: bloc.attributes.length,
                    ),
                  );
                },
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              _buildRadioGroup(
                title: context.localizations.isAvailable,
                value: _isAva,
                context: context,
                onChanged: (value) => setState(() => _isAva = value!),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductActionSuccess &&
                      selectedAttributes.isEmpty &&
                      !state.isInit) {
                    Navigator.pop(context);
                    AppConstant.showCustomSnakeBar(context, state.msg, true);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    isLoading: state is ProductActionLoading,
                    text: selectedAttributes.isEmpty
                        ? context.localizations.addProduct
                        : context.localizations.next,
                    press: state is ProductActionLoading
                        ? () {}
                        : _submitProduct,
                    width: double.infinity,
                    height: 50,
                  );
                },
              ),
              SizedBox(height: SizeConfig.bodyHeight * .04),
            ],
          ).scrollable(),
        ),
      ),
    );
  }

  Widget _buildRadioGroup({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required BuildContext context,
  }) {
    return Row(
      children: [
        AppText(text: title, fontWeight: FontWeight.bold, textSize: 11),
        SizedBox(width: 8.w),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: value,
              onChanged: onChanged,
              activeColor: Colors.orange,
            ),
            AppText(
              text: context.localizations.yes,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 24.w),
            Radio<bool>(
              value: false,
              groupValue: value,
              onChanged: onChanged,
              activeColor: Colors.orange,
            ),
            AppText(
              text: title == context.localizations.isMultiple
                  ? context.localizations.singleChoice
                  : context.localizations.no,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}
