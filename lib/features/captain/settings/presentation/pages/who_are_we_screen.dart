import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:taxito/features/captain/settings/presentation/pages/privacy_policy_screen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/settings_entity.dart';
import '../widgets/settings/settings_item_design.dart';

class WhoAreWeScreen extends StatelessWidget {
  const WhoAreWeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.localizations.whoAreU,
      ),
      body: Padding(
        padding: screenPadding(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            const AppText(
              text: AppStrings.appName,
              fontWeight: FontWeight.bold,
              textSize: 15,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            AppText(
              text: context.localizations.whoAreU1,
              fontWeight: FontWeight.w500,
              textSize: 13,
              color: context.colorScheme.shadow,
              maxLines: 2,
              textHeight: 1.5,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
            SettingsItemDesign(
              settingsEntity: SettingsEntity(
                id: 1,
                press: () => context.navigateTo(const PrivacyPolicyScreen(
                  page: 7,
                )),
                title: context.localizations.ourMessage,
              ),
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
            SettingsItemDesign(
              settingsEntity: SettingsEntity(
                id: 1,
                press: () => context.navigateTo(const PrivacyPolicyScreen(
                  page: 2,
                )),
                title: context.localizations.ourVision,
              ),
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
            SettingsItemDesign(
              settingsEntity: SettingsEntity(
                id: 1,
                press: () => context.navigateTo(const PrivacyPolicyScreen(
                  page: 3,
                )),
                title: context.localizations.whatDoWeOffer,
              ),
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
            SettingsItemDesign(
              settingsEntity: SettingsEntity(
                id: 1,
                press: () => context.navigateTo(const PrivacyPolicyScreen(
                  page: 1,
                )),
                title: context.localizations.whyWe,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
