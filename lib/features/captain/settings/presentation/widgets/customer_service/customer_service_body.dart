import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/chat/presentation/pages/message_screen.dart';
import 'package:taxito/features/captain/driver_trip/data/models/trip_model.dart';
import 'package:taxito/features/captain/settings/presentation/bloc/settings_bloc.dart';
import 'package:taxito/features/captain/settings/presentation/pages/faq_question_screen.dart';
import 'package:taxito/features/captain/settings/settings_helper.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../domain/entities/settings_entity.dart';
import '../../pages/privacy_policy_screen.dart';
import '../../pages/who_are_we_screen.dart';
import '../settings/settings_item_design.dart';

class CustomerServiceBody extends StatelessWidget {
  const CustomerServiceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        children: [
          Row(
            children: [
              buildHeaderItem(
                  onTap: () =>
                      SettingsHelper.contactUsWithPhoneNumber(
                          phoneNumber: context
                              .read<SettingsBloc>()
                              .settingsModel
                              ?.firstPhone ??
                              ""),
                  context: context,
                  title: context.localizations.call,
                  image: Assets.images.callGreen.path),
              buildHeaderItem(
                  onTap: () async => context.navigateTo(MessageScreen(tripModel:TripModel())),
                  context: context,
                  title: context.localizations.sendSuggestion,
                  image: Assets.images.suggestion.path),
            ],
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .04,
          ),
          SettingsItemDesign(
            settingsEntity: SettingsEntity(
              id: 1,
              iconColor: Colors.green,
              press: () => context.navigateTo(const WhoAreWeScreen()),
              /*press: () => context.navigateTo(const PrivacyPolicyScreen(
                page: 1,
              )),*/
              title: context.localizations.whoAreU,
            ),
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .02,
          ),
          SettingsItemDesign(
            settingsEntity: SettingsEntity(
              id: 1,
              iconColor: Colors.green,
              press: () =>
                  context.navigateTo(const PrivacyPolicyScreen(
                    page: 5,
                  )),
              title: context.localizations.privacyPolicy,
            ),
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .02,
          ),
          SettingsItemDesign(
            settingsEntity: SettingsEntity(
              id: 1,
              press: () =>
                  context.navigateTo(const PrivacyPolicyScreen(
                    page: 6,
                  )),
              title: context.localizations.termsAndConditions,
            ),
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .02,
          ),
          SettingsItemDesign(
            settingsEntity: SettingsEntity(
              id: 1,
              press: () => context.navigateTo(const FaqQuestionScreen()),
              title: context.localizations.faq,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderItem({required String title,
    required String image,
    required VoidCallback onTap,
    required BuildContext context}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: SizeConfig.bodyHeight * .1,
              width: SizeConfig.bodyHeight * .14,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: AppImage.asset(image),
            ),
            10.verticalSpace,
            AppText(text: title)
          ],
        ),
      ),
    );
  }
}