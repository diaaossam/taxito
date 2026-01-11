import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/captain/driver_main/presentation/widgets/driver_main_layout/driver_toggle_button.dart';
import 'package:taxito/features/captain/notifications/presentation/pages/notification_screen.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/enum/choose_enum.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/image_picker/app_image.dart';

class DriverHomeActions extends StatelessWidget {
  final Function(ChooseEnum) callbackAvailability;

  const DriverHomeActions({super.key, required this.callbackAvailability});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(border: Border.all(color: context.colorScheme.outline),                      borderRadius: BorderRadius.circular(12),
          ),
      padding: screenPadding(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: context.localizations.yourStatus,
            fontWeight: FontWeight.w600,
          ),
          DriverToggleButton(
            callbackAvailability: callbackAvailability,
          ),
          IconButton(
              onPressed: () =>context.navigateTo(const NotificationScreen()),
              icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.colorScheme.outline,
                      )),
                  child: AppImage.asset(Assets.icons.notification)))
        ],
      ),
    );
  }
}
