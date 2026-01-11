import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/enum/user_type.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import 'login_form.dart';

class LoginBodyWidget extends StatelessWidget {
  final UserType userType;

  const LoginBodyWidget({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImage.asset(
            Assets.images.login.path,
            height: SizeConfig.bodyHeight * .3,
            width: SizeConfig.bodyHeight * .3,
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .04,
          ),
          AppText(
            text: context.localizations.login,
            fontWeight: FontWeight.bold,
            maxLines: 1,
            textSize: 20,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText(
            text: context.localizations.loginBody,
            maxLines: 1,
            textSize: 13,
            fontWeight: FontWeight.w400,
            color: context.colorScheme.shadow,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .06),
          LoginForm(
            userType: userType,
          ),
        ],
      ).scrollable(),
    );
  }
}
