import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/theme/theme_helper.dart';

class CustomChatTextField extends StatelessWidget {
  final Function(String) onChange;

  const CustomChatTextField({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FormBuilderTextField(
        name: "chat",
        onChanged: (value) => onChange(value ?? ""),
        decoration: InputDecoration(
          isDense: true,
          counter: const SizedBox.shrink(),
          hintText: context.localizations.sendMessage,
          hintStyle: ThemeHelper().hintTFFTextStyle(),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          fillColor: context.colorScheme.inversePrimary,
          focusColor: context.colorScheme.surface,
          suffixIconConstraints:
              BoxConstraints(maxHeight: 40.h, minHeight: 10.h, minWidth: 40.w),
          prefixIconConstraints:
              BoxConstraints(maxHeight: 40.h, minHeight: 10.h, minWidth: 40.w),
          filled: true,
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        textCapitalization: TextCapitalization.none,
        style: ThemeHelper().mainTFFTextStyle(context),
        textAlign: TextAlign.start,
        maxLines: null,
        autofocus: false,
      ),
    );
  }
}
