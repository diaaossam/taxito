import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/image_picker/app_image.dart';

class WaitingForReviewScreen extends StatelessWidget {
  const WaitingForReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.bodyHeight * .2,
            ),
            AppImage.asset(
              Assets.images.completeRegister.path,
              height: SizeConfig.bodyHeight * .4,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .1,
            ),
            AppText(
              text: context.localizations.yourRequestUnderReview,
              fontWeight: FontWeight.bold,
              textSize: 18,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * .04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    text: context.localizations.yourRequestUnderReview1,
                    maxLines: 5,
                    align: TextAlign.center,
                    textSize: 14,
                  ),
                  4.horizontalSpace,
                  AppText(
                    text: "24",
                    color: context.colorScheme.primary,
                    maxLines: 5,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.center,
                    textSize: 14,
                  ),
                  4.horizontalSpace,
                  AppText(
                    text: context.localizations.to,
                    maxLines: 5,
                    align: TextAlign.center,
                    textSize: 14,
                  ),
                  4.horizontalSpace,
                  AppText(
                    text: "48",
                    color: context.colorScheme.primary,
                    maxLines: 5,
                    fontWeight: FontWeight.bold,
                    align: TextAlign.center,
                    textSize: 14,
                  ),
                  4.horizontalSpace,
                  AppText(
                    text: context.localizations.hour,
                    maxLines: 5,
                    align: TextAlign.center,
                    textSize: 14,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .09,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * .04),
              child: CustomButton(
                  text: context.localizations.login,
                  press: () {
                    context.navigateToAndFinish(const LoginScreen());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
