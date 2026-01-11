import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/generated/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../data/models/attribute_model.dart';
import '../../cubit/attributes_cubit.dart';

class AddEditAttributeForm extends StatefulWidget {
  final AttributeModel? model;

  const AddEditAttributeForm({super.key, this.model});

  @override
  State<AddEditAttributeForm> createState() => _AddEditAttributeFormState();
}

class _AddEditAttributeFormState extends State<AddEditAttributeForm> {
  bool _isRequired = false;
  bool _isColor = false;
  bool _isMultiple = false;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    if (widget.model != null) {
      _isRequired = widget.model!.isRequired ?? false;
      _isColor = widget.model!.isColor ?? false;
      _isMultiple = widget.model!.isMultiple ?? false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Padding(
        padding: screenPadding(),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.bodyHeight * .03),
              CustomTextFormField(
                name: "arabic",
                hintText: context.localizations.arabicAttributeName,
                title: context.localizations.arabicAttributeName,
                validator: FormBuilderValidators.required(),
                initialValue: widget.model?.titleAr,
              ),
              SizedBox(height: 25.h),
              CustomTextFormField(
                name: "english",
                title: context.localizations.englishAttributeName,
                hintText: context.localizations.englishAttributeName,
                validator: FormBuilderValidators.required(),
                initialValue: widget.model?.titleEn,
              ),
              SizedBox(height: 24.h),
              _buildRadioGroup(
                title: S.of(context).isRequired,
                value: _isRequired,
                context: context,
                onChanged: (value) => setState(() => _isRequired = value!),
              ),
              SizedBox(height: 16.h),
              _buildRadioGroup(
                title: S.of(context).isColor,
                value: _isColor,
                context: context,
                onChanged: (value) => setState(() => _isColor = value!),
              ),
              SizedBox(height: 16.h),
              _buildRadioGroup(
                title: S.of(context).isMultiple,
                value: _isMultiple,
                context: context,
                onChanged: (value) => setState(() => _isMultiple = value!),
              ),
              SizedBox(height: 40.h),
              BlocConsumer<AttributesCubit, AttributesState>(
                listener: (context, state) {
                  if (state is AttributesActionFailure) {
                    AppConstant.showCustomSnakeBar(context, state.msg, false);
                  }
                  if (state is AttributesActionSuccess) {
                    Navigator.pop(context, true);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    isLoading: state is AttributesActionLoading,
                    text: context.localizations.saveAttribute,
                    press: () {
                      if (!_formKey.currentState!.saveAndValidate()) {
                        return;
                      }
                      if (widget.model != null) {
                        context.read<AttributesCubit>().update(
                          id: widget.model!.id!,
                          ar: _formKey.fieldValue("arabic"),
                          en: _formKey.fieldValue("english"),
                          isRequired: _isRequired,
                          isMultiple: _isMultiple,
                          isColor: _isColor,
                        );
                      } else {
                        context.read<AttributesCubit>().add(
                          ar: _formKey.fieldValue("arabic"),
                          en: _formKey.fieldValue("english"),
                          isRequired: _isRequired,
                          isMultiple: _isMultiple,
                          isColor: _isColor,
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ).scrollable(),
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
