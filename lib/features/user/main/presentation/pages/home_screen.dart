import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/api_config.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/main/presentation/widgets/home/home_body.dart';
import 'package:aslol/features/notifications/presentation/pages/notification_screen.dart';
import 'package:aslol/features/settings/settings_helper.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import '../../../user/presentation/widgets/home_user_design.dart';

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
        leadingWidth: SizeConfig.screenWidth*.8,
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
                  shape: BoxShape.circle),
              child: AppImage.asset(Assets.icons.notification),
            ),
          ),
        ],
      ),
      body: const HomeBody(),
    );
  }
}
