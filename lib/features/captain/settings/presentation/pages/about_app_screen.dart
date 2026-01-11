import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../config/theme/theme_helper.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_app_bar.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../bloc/settings_bloc.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.localizations.aboutApp),
      body: Center(
        child: Padding(
          padding: screenPadding(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppImage.asset(
                Assets.images.logoCirclure.path,
                height: SizeConfig.bodyHeight * 0.15,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .04),
              ReadMoreText(
                context
                    .read<SettingsBloc>()
                    .settingsModel!
                    .description
                    .toString(),
                trimMode: TrimMode.Line,
                trimLines: 5,
                colorClickableText: context.colorScheme.primary,
                trimCollapsedText: context.localizations.showMore,
                trimExpandedText: context.localizations.showLess,
                lessStyle: ThemeHelper().appTextStyle(
                  context: context,
                  fontFamily: AppStrings.arabicFont,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.primary,
                  textHeight: 1.2,
                  textSize: 12.sp,
                ),
                moreStyle: ThemeHelper().appTextStyle(
                  context: context,
                  fontFamily: AppStrings.arabicFont,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.primary,
                  textHeight: 1.2,
                  textSize: 12.sp,
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .04),
              AppText(
                text: context.localizations.develop,
                fontWeight: FontWeight.w500,
                textSize: 18,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .01),
              AppImage.asset(
                Assets.images.jacksi.path,
                height: SizeConfig.bodyHeight * 0.2,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              const AppText(
                text: "jacksi.co.uk",
                fontWeight: FontWeight.w600,
                textSize: 15,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      text: context.localizations.contactUs3,
                      press: () =>
                          launchUrl(Uri.parse("https://jacksi.co.uk/")),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
