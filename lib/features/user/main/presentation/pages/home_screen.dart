import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/main/presentation/widgets/home/home_body.dart';
import 'package:taxito/features/user/notifications/presentation/pages/notification_screen.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:taxito/widgets/custom_app_bar.dart';

import '../../../../captain/settings/settings_helper.dart';
import '../widgets/home_user_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: SizeConfig.screenWidth * .8,
        leadingWidget: const HomeUserDesign(),
        actions: [
          InkWell(
            onTap: () {
              if (ApiConfig.isGuest == true) {
                SettingsHelper().showGuestDialog(context);
                return;
              }
              context.navigateTo(const NotificationScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.colorScheme.background,
                shape: BoxShape.circle,
              ),
              child: AppImage.asset(Assets.icons.notification),
            ),
          ),
        ],
      ),
      body: const HomeBody(),
    );
  }
}
