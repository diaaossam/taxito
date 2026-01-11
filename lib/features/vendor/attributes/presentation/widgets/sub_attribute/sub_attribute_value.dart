import 'package:taxito/core/bloc/global_cubit/global_cubit.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/sub_attribute_value_model.dart';

class SubAttributeValue extends StatefulWidget {
  final SubAttributeValueModel value;
  final bool isColorAttribute;
  final bool hasImages;
  final Function(SubAttributeValueModel) onValueChanged;
  final VoidCallback? onImageTap;
  final VoidCallback? onColorTap;

  const SubAttributeValue({
    super.key,
    required this.value,
    required this.isColorAttribute,
    required this.hasImages,
    required this.onValueChanged,
    this.onImageTap,
    this.onColorTap,
  });

  @override
  State<SubAttributeValue> createState() => _SubAttributeValueState();
}

class _SubAttributeValueState extends State<SubAttributeValue> {
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(
      text: widget.value.price?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLan = context.read<GlobalCubit>().locale.languageCode;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: widget.value.isSelected ?? false,
                onChanged: (value) {
                  setState(() {
                    widget.value.isSelected = value;
                  });
                  widget.onValueChanged(widget.value);
                },
                activeColor: Colors.orange,
              ),
              Expanded(
                child: AppText(
                  text:currentLan == "en"?  widget.value.nameEn ?? '' : widget.value.nameAr??"",
                  fontWeight: FontWeight.w500,
                  textSize: 14,
                ),
              ),
              if (widget.hasImages && !widget.isColorAttribute) ...[
                GestureDetector(
                  onTap: widget.onImageTap,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: widget.value.imagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              widget.value.imagePath!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
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
              if (widget.isColorAttribute) ...[
                GestureDetector(
                  onTap: widget.onColorTap,
                  child: Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(
                      color: widget.value.color != null
                          ? Color(int.parse(widget.value.color!.replaceFirst('#', '0xff')))
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (widget.value.isSelected == true) ...[
            12.verticalSpace,
            CustomTextFormField(
              controller: _priceController,
              title: '${context.localizations.price} (${currentLan == "en"?widget.value.nameEn: widget.value.nameAr})',
              hintText: context.localizations.price,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.value.price = double.tryParse(value ?? '');
                widget.onValueChanged(widget.value);
              },
            ),
          ],
        ],
      ),
    );
  }
}
