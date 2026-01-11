import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/auth/data/models/response/user_model_helper.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPointsDialog extends StatelessWidget {
  const MyPointsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: SizeConfig.bodyHeight * .5,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.bodyHeight * .03,
            ),
            AppText(
              text: context.localizations.myPoints,
              fontWeight: FontWeight.w600,
              textSize: 15,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            AppText(
              text: context.localizations.redeemPointsBody,
              fontWeight: FontWeight.w500,
              textSize: 13,
              maxLines: 4,
              textHeight: 1.8,
              color: context.colorScheme.shadow,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .06,
            ),
            AppText(
              text: UserDataService().getUserData()!.points.toString(),
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
              textSize: 30,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .06,
            ),
            CustomTextFormField(
              suffixIcon: const Icon(Icons.copy),
              readOnly: true,
              controller: TextEditingController(text: UserDataService().getUserData()?.code),
              onTap: () {
                Clipboard.setData(ClipboardData(text: UserDataService().getUserData()!.code.toString()));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(context.localizations.copiedToClipboard),
                ));
              },

            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .03,
            ),
            CustomButton(text: context.localizations.copy, press: () {
              Clipboard.setData(ClipboardData(text: UserDataService().getUserData()!.code.toString()));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(context.localizations.copiedToClipboard),
              ));
            },)
          ],
        ),
      ),
    );
  }
}
