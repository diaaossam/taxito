import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:taxito/core/bloc/global_cubit/global_cubit.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import '../../../../../../widgets/image_picker/media_form_field.dart';
import '../../../../../../widgets/image_picker/pick_image_sheet.dart';
import '../../../../../captain/delivery_order/data/models/response/attributes_model.dart';
import 'package:taxito/core/data/models/product_model.dart';
import '../../../data/models/attribute_model.dart';
import '../../../data/models/sub_attribute_value_model.dart';

class SubAttributeItem extends StatefulWidget {
  final AttributeModel model;
  final ProductModel? productModel;
  final Function(List<SubAttributeValueModel>) onValuesChanged;

  const SubAttributeItem({
    super.key,
    required this.model,
    this.productModel,
    required this.onValuesChanged,
  });

  @override
  State<SubAttributeItem> createState() => _SubAttributeItemState();
}

class _SubAttributeItemState extends State<SubAttributeItem>
    with AutomaticKeepAliveClientMixin {
  bool _hasImages = false;
  final TextEditingController _newValueControllerAr = TextEditingController();
  final TextEditingController _newValueControllerEn = TextEditingController();
  final List<SubAttributeValueModel> _values = [];
  final Map<num, TextEditingController> _priceControllers = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadInitialValues();
  }

  void _loadInitialValues() {
    if (widget.productModel?.attributes == null) return;
    final matchingAttribute = widget.productModel!.attributes!
        .cast<AttributesModel?>()
        .firstWhere(
          (attr) => attr?.attributeId == widget.model.id,
          orElse: () => null,
        );

    if (matchingAttribute == null || matchingAttribute.values == null) return;

    // Convert Values to SubAttributeValueModel
    final initialValues = matchingAttribute.values!.map((value) {
      return SubAttributeValueModel(
        id: value.attributeValueId ?? DateTime.now().millisecondsSinceEpoch,
        nameAr: value.title ?? '',
        // Will be used for both Ar and En since API returns single title
        nameEn: value.title ?? '',
        price: value.price?.toDouble() ?? 0,
        isSelected: true,
        // Mark as selected since these are existing values
        imagePath: value.image,
        // This will be the URL from server
        color: value.hexCode,
        attributeId: widget.model.id,
      );
    }).toList();

    // Check if any values have images to set _hasImages correctly
    final hasAnyImages = initialValues.any(
      (v) => v.imagePath != null && v.imagePath!.isNotEmpty,
    );

    setState(() {
      _values.addAll(initialValues);
      _hasImages = hasAnyImages;
    });

    // Notify parent about initial values
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onValuesChanged(_values);
    });

    Logger().i(
      'Loaded ${initialValues.length} initial values for attribute ${widget.model.title}, hasImages: $_hasImages',
    );
  }

  TextEditingController _getPriceController(SubAttributeValueModel value) {
    if (!_priceControllers.containsKey(value.id)) {
      _priceControllers[value.id!] = TextEditingController(
        text: value.price?.toString() ?? '',
      );
    }
    return _priceControllers[value.id!]!;
  }

  void _addNewValue() {
    if (_newValueControllerAr.text.trim().isNotEmpty &&
        _newValueControllerEn.text.trim().isNotEmpty) {
      final newValue = SubAttributeValueModel(
        id: DateTime.now().millisecondsSinceEpoch,
        nameAr: _newValueControllerAr.text.trim(),
        nameEn: _newValueControllerEn.text.trim(),
        price: 0,
        isSelected: false,
        attributeId: widget.model.id,
      );

      setState(() => _values.add(newValue));
      _newValueControllerAr.clear();
      _newValueControllerEn.clear();
      widget.onValuesChanged(_values);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final currentLan = context.read<GlobalCubit>().locale.languageCode;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * .04,
        vertical: SizeConfig.bodyHeight * .02,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * .04,
        vertical: SizeConfig.bodyHeight * .01,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.shadow.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: widget.model.title ?? '',
            fontWeight: FontWeight.bold,
            textSize: 14,
          ),
          16.verticalSpace,
          if (!widget.model.isColor!) ...[
            AppText(
              text: context.localizations.doesItContainImages,
              fontWeight: FontWeight.w500,
            ),
            8.verticalSpace,
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: _hasImages,
                  onChanged: (value) {
                    Logger().w(
                      '${widget.model.title}: Setting hasImages to $value, current values count: ${_values.length}',
                    );
                    setState(() => _hasImages = value ?? false);
                  },
                  activeColor: Colors.orange,
                ),
                AppText(text: context.localizations.yes, textSize: 14),
                16.horizontalSpace,
                Radio<bool>(
                  value: false,
                  groupValue: _hasImages,
                  onChanged: (value) {
                    Logger().w(
                      '${widget.model.title}: Setting hasImages to ${value}, current values count: ${_values.length}',
                    );
                    setState(() {
                      _hasImages = value ?? false;
                    });
                  },
                  activeColor: Colors.orange,
                ),
                AppText(text: context.localizations.no, textSize: 14),
              ],
            ),
          ],
          5.verticalSpace,
          AppText(
            text:
                '${context.localizations.addNewValuesFor} ${widget.model.title}',
            fontWeight: FontWeight.w500,
            textSize: 14,
          ),
          8.verticalSpace,
          CustomTextFormField(
            controller: _newValueControllerAr,
            hintText: context.localizations.writeValueHereAr,
            textInputAction: TextInputAction.done,
          ),
          10.verticalSpace,
          CustomTextFormField(
            controller: _newValueControllerEn,
            hintText: context.localizations.writeValueHereEn,
            textInputAction: TextInputAction.done,
          ),
          10.verticalSpace,
          CustomButton(
            text: widget.model.isColor == true
                ? context.localizations.addNewColor
                : context.localizations.addValue,
            press: _addNewValue,
            height: 40.h,
            textSize: 12,
          ),
          16.verticalSpace,
          if (_values.isNotEmpty) ...[
            AppText(
              text: context.localizations.addedValues,
              fontWeight: FontWeight.w500,
              textSize: 12,
            ),
            8.verticalSpace,
            SizedBox(
              height: 60.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _values
                      .map(
                        (value) => Container(
                          margin: EdgeInsets.only(right: 8.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: value.isSelected ?? false,
                                onChanged: (checked) {
                                  setState(() {
                                    value.isSelected = checked;
                                  });
                                  widget.onValuesChanged(_values);
                                },
                                activeColor: Colors.orange,
                              ),
                              AppText(
                                text: currentLan == "en"
                                    ? value.nameEn ?? ''
                                    : value.nameAr ?? "",
                                fontWeight: FontWeight.w500,
                                textSize: 14,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            5.verticalSpace,
            Column(
              children: _values.where((value) => value.isSelected == true).map((
                value,
              ) {
                return Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: _getPriceController(value),
                          title:
                              '${context.localizations.price} (${currentLan == "en" ? value.nameEn : value.nameAr})',
                          hintText: '200 ${context.localizations.iqd}',
                          keyboardType: TextInputType.number,
                          onChanged: (newValue) {
                            value.price = double.tryParse(newValue ?? '');
                            widget.onValuesChanged(_values);
                          },
                        ),
                      ),
                      if (_hasImages && !widget.model.isColor!) ...[
                        8.horizontalSpace,
                        GestureDetector(
                          onTap: () async {
                            await showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) => PickMediaFileSheet(
                                mediaType: MediaType.image,
                                onPickFile: (file, thumbnail) {
                                  String data = file.path;
                                  final index = _values.indexWhere(
                                    (v) => v.id == value.id,
                                  );
                                  if (index != -1) {
                                    setState(
                                      () => _values[index].imagePath = data,
                                    );
                                    widget.onValuesChanged(_values);
                                  }
                                },
                              ),
                            );
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: value.imagePath != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: value.imagePath!.startsWith('http')
                                        ? Image.network(
                                            value.imagePath!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.add_photo_alternate,
                                                    color: Colors.grey.shade400,
                                                    size: 20.sp,
                                                  );
                                                },
                                          )
                                        : Image.file(
                                            File(value.imagePath!),
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.add_photo_alternate,
                                                    color: Colors.grey.shade400,
                                                    size: 20.sp,
                                                  );
                                                },
                                          ),
                                  )
                                : Icon(
                                    Icons.add_photo_alternate,
                                    color: Colors.grey.shade400,
                                    size: 20.sp,
                                  ),
                          ),
                        ),
                      ],
                      if (widget.model.isColor!) ...[
                        8.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: SizeConfig.bodyHeight * .04,
                                    ),
                                    ColorPicker(
                                      pickerColor: context.colorScheme.surface,
                                      onColorChanged: (selectedColor) {
                                        String data = selectedColor
                                            .toHexString()
                                            .replaceFirst("FF", "#");
                                        final index = _values.indexWhere(
                                          (v) => v.id == value.id,
                                        );
                                        if (index != -1) {
                                          setState(
                                            () => _values[index].color = data,
                                          );
                                          widget.onValuesChanged(_values);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: value.color != null
                                  ? Color(
                                      int.parse(
                                        value.color!.replaceFirst('#', '0xff'),
                                      ),
                                    )
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: value.color != null
                                ? null
                                : Icon(
                                    Icons.palette,
                                    color: Colors.grey.shade400,
                                    size: 20.sp,
                                  ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _newValueControllerAr.dispose();
    _newValueControllerEn.dispose();
    // Dispose all price controllers
    for (var controller in _priceControllers.values) {
      controller.dispose();
    }
    _priceControllers.clear();
    super.dispose();
  }
}
