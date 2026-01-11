import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/image_picker/app_image.dart';

class PhoneFieldWidget extends StatelessWidget {
  final String? phone;
  final bool isWithTitle;
  final bool readOnly;

  const PhoneFieldWidget({super.key, this.phone, this.isWithTitle = true, this.readOnly=false});

  @override
  Widget build(BuildContext context) {
    String? initialPhone = phone?.substring(4);
    return CustomTextFormField(
      name: "phone",
      maxLength: 12,
      readOnly: readOnly,
      initialValue: initialPhone,
      title: isWithTitle ? context.localizations.phoneNumber : null,
      valueTransformer: (value) => "+964$value",
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.phoneNumber(
            errorText: context.localizations.validation),
        FormBuilderValidators.required(
            errorText: context.localizations.validation),
      ]),
      hintText: context.localizations.phoneNumber,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      keyboardType: TextInputType.phone,
      prefixIcon: AppImage.asset(Assets.icons.call),
    );
  }
}
