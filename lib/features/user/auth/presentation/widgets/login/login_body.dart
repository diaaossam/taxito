import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_form.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.bodyHeight * .2,
          ),
          AppImage.asset(
            Assets.images.logoCirclure.path,
            height: SizeConfig.bodyHeight * .17,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text: context.localizations.loginTitle,
                fontWeight: FontWeight.w600,
                maxLines: 1,
                textSize: 22,
              ),
              5.horizontalSpace,
              AppText(
                text: context.localizations.loginTitle2,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.primary,
                textSize: 22,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText(
            text: context.localizations.loginBody,
            maxLines: 6,
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
