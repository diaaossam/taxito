import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import 'login_form.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.bodyHeight * .04,
          ),
          AppImage.asset(
            Assets.images.logoCirclure.path,
            height: SizeConfig.bodyHeight * .2,
            width: SizeConfig.bodyHeight * .2,
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .04,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: context.localizations.login,
                fontWeight: FontWeight.bold,
                maxLines: 1,
                textSize: 16,
              ),
              5.horizontalSpace,
              AppText(
                text: "${context.localizations.appName} !",
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
                maxLines: 1,
                textSize: 16,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText(
            text: context.localizations.loginBody,
            maxLines: 2,
            textSize: 13,
            fontWeight: FontWeight.w400,
            color: context.colorScheme.shadow,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .06),
          LoginForm(),
        ],
      ).scrollable(),
    );
  }
}
