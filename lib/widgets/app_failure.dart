import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';

import 'app_text.dart';
import 'custom_button.dart';
class AppFailureWidget extends StatelessWidget {
  final String? title;
  final String? body;
  final String? image;
  final VoidCallback? callback;
  final VoidCallback? back;
  final String? buttonText;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const AppFailureWidget({
    super.key,
    this.title,
    this.body,
    this.padding,
    this.image,
    this.callback,
    this.buttonText,
    this.height,
    this.back,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.bodyHeight * .04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height ?? SizeConfig.bodyHeight * .2),
            AppImage.asset(
              image ?? Assets.images.logoCirclure.path,
              width: SizeConfig.screenWidth * .45,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .04),
            AppText(
              text: title ?? context.localizations.thereIsError,
              textSize: 13,
              fontWeight: FontWeight.w600,
              align: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            AppText.hint(
              text: body ?? "",
              textSize: 12,
              maxLines: 40,
              align: TextAlign.center,
            ),
            const Spacer(),
            CustomButton(
              text: buttonText ?? context.localizations.back,
              press: callback ?? () => Navigator.pop(context),
              backgroundColor: Colors.transparent,
              borderColor: context.colorScheme.onSurface,
              textColor: context.colorScheme.onSurface,
            ),
            if (back != null) ...[
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomButton(
                text: context.localizations.back,
                press: () => Navigator.pop(context),
                backgroundColor: Colors.transparent,
                borderColor: context.colorScheme.onSurface,
                textColor: context.colorScheme.onSurface,
              ),
            ],

            SizedBox(height: SizeConfig.bodyHeight * .04),
          ],
        ),
      ),
    );
  }
}
