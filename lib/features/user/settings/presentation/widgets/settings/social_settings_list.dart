import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import '../../../../../captain/settings/presentation/bloc/settings_bloc.dart';
import '../../../../../captain/settings/settings_helper.dart';
import 'social_settings_button.dart';

class SocialSettingsList extends StatelessWidget {
  final bool isInPay;

  const SocialSettingsList({super.key, required this.isInPay});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: screenPadding(),
        child: Column(
          children: [
            Row(
              children: [
                SocialSettingsButton(
                  icon: Assets.icons.arrowDown,
                  press: () => SettingsHelper.openInstagram(
                    bloc.settingsModel?.instagramLink ?? "",
                  ),
                ),
                const SizedBox(width: 10),
                SocialSettingsButton(
                  icon: Assets.icons.arrowDown,
                  press: () => SettingsHelper.openTikTok(
                    bloc.settingsModel?.tiktokLink ?? "",
                  ),
                ),
                const SizedBox(width: 10),
                SocialSettingsButton(
                  icon: Assets.icons.arrowDown,
                  press: () => SettingsHelper.openFacebook(
                    bloc.settingsModel?.facebookLink ?? "",
                  ),
                ),
                const SizedBox(width: 10),
                SocialSettingsButton(
                  icon: Assets.icons.arrowDown,
                  press: () => SettingsHelper.contactUsWithWhatsApp(
                    phoneNumber: bloc.settingsModel?.whatsappPhone ?? "",
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
