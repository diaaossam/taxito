import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../../settings/settings_helper.dart';

class ComminucationOrderWidget extends StatelessWidget {
  final String phone;

  const ComminucationOrderWidget({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () =>
              SettingsHelper.contactUsWithPhoneNumber(phoneNumber: phone),
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: context.colorScheme.outline)),
                padding: const EdgeInsets.all(4),
                child: AppImage.asset(
                  Assets.icons.callTrip,
                  size: 22,
                )),
          ),
        ),
        4.horizontalSpace,
        GestureDetector(
          onTap: () => SettingsHelper.contactUsWithWhatsApp(phoneNumber: phone),
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: context.colorScheme.outline)),
                padding: const EdgeInsets.all(4),
                child: AppImage.asset(
                  Assets.icons.logosWhatsappIcon,
                  size: 22,
                )),
          ),
        ),
      ],
    );
  }
}
