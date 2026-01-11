import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/main/presentation/pages/main_layout.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/image_picker/app_image.dart';

class ScheduledDailogDesign extends StatelessWidget {
  const ScheduledDailogDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SizedBox(
        height: SizeConfig.bodyHeight * .7,
        child: AlertDialog(
          content: SizedBox(
            height: SizeConfig.bodyHeight * .7,
            child: Column(
              children: [
                SizedBox(height: SizeConfig.bodyHeight * .04),
                AppText(
                  text: context.localizations.schTitle,
                  fontWeight: FontWeight.w600,
                  textSize: 18,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                AppText(
                  text: context.localizations.schBody,
                  textSize: 13,
                  maxLines: 2,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .05),
                AppImage.asset(
                  Assets.images.searchingForDriver.path,
                  height: SizeConfig.bodyHeight * .35,
                  width: SizeConfig.bodyHeight * .35,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .1),
                CustomButton(
                  text: context.localizations.home,
                  press: () => context.navigateToAndFinish(const MainLayout()),
                  backgroundColor: Colors.transparent,
                  textColor: context.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
