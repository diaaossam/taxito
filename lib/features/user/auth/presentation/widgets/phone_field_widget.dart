import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:aslol/config/theme/theme_helper.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';

class PhoneFieldWidget extends StatelessWidget {
  final String? phone;
  final bool isWithTitle;
  final bool enabled;

  const PhoneFieldWidget({super.key, this.phone, this.isWithTitle = true, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FormBuilderField(
        name: "phone",
        initialValue: phone,
        validator: (value) {
          if (phone != null && phone!.isNotEmpty) {
            return null;
          }
          if (value == null || value.toString().isEmpty) {
            return context.localizations.validation;
          } else if (value.toString().length < 9 ||
              value.toString().length > 15) {
            return context.localizations.wrongPhoneNumber;
          }
          return null;
        },
        builder: (FormFieldState<String> field) {
          return IntlPhoneField(
            disableLengthCheck: true,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
            ],
            initialCountryCode: 'IQ',

            countries: const [
              Country(
                name: "Iraq",
                nameTranslations: {
                  "sk": "Irak",
                  "se": "Irak",
                  "pl": "Irak",
                  "no": "Irak",
                  "ja": "イラク",
                  "it": "Iraq",
                  "zh": "伊拉克",
                  "nl": "Irak",
                  "de": "Irak",
                  "fr": "Irak",
                  "es": "Irak",
                  "en": "Iraq",
                  "pt_BR": "Iraque",
                  "sr-Cyrl": "Ирак",
                  "sr-Latn": "Irak",
                  "zh_TW": "伊拉克",
                  "tr": "Irak",
                  "ro": "Irak",
                  "ar": "العراق",
                  "fa": "عراق",
                  "yue": "伊拉克"
                },
                flag: "🇮🇶",
                code: "IQ",
                dialCode: "964",
                minLength: 10,
                maxLength: 10,
              ),
            ],
            initialValue: phone,
            enabled:enabled ,
            dropdownIconPosition: IconPosition.leading,
            flagsButtonPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
            dropdownIcon: const Icon(Icons.keyboard_arrow_down_sharp),
            pickerDialogStyle: PickerDialogStyle(
              backgroundColor: context.colorScheme.primaryContainer,
            ),
            style: ThemeHelper().mainTFFTextStyle(context),
            cursorColor: Colors.black,
            onChanged: (phone) {
              field.didChange(phone.completeNumber); // هنا نحدث قيمة الحقل
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: ThemeHelper().buildMainTffBorder(context: context),
              enabledBorder: ThemeHelper().buildMainTffBorder(context: context),
              errorText: field.errorText,
              filled: true,
              contentPadding: REdgeInsetsDirectional.only(start: 20, top: 10, bottom: 10, end: 20),
              fillColor: context.colorScheme.surface,
              errorStyle: const TextStyle(color: Colors.red),
              disabledBorder: ThemeHelper().buildMainTffBorder(context: context),
              focusedBorder: ThemeHelper().buildMainTffBorder(context: context),
              focusedErrorBorder: ThemeHelper().buildErrorBorder(),
              errorBorder: ThemeHelper().buildErrorBorder(),
              hintText: context.localizations.phoneNumber,
              hintStyle: ThemeHelper().hintTFFTextStyle(),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
            invalidNumberMessage: context.localizations.wrongPhoneNumber,

          );
        },
      ),
    );
  }
}
