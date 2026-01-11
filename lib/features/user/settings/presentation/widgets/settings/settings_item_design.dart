import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aslol/config/theme/theme_helper.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/settings/domain/entities/settings_entity.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:aslol/widgets/rotate.dart';

class SettingsItemDesign extends StatelessWidget {
  final SettingsEntity settingsEntity;

  const SettingsItemDesign({super.key, required this.settingsEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: settingsEntity.press,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.colorScheme.outline)),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * .04,
            vertical: SizeConfig.bodyHeight * .018),
        child: Row(
          children: [
            if(settingsEntity.image != null)
            Center(
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    shape: BoxShape.circle),
                child: AppImage.asset(
                  settingsEntity.image!,
                  color: settingsEntity.iconColor,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.screenWidth * .02,
            ),
            Expanded(
                child: AppText(
              text: settingsEntity.title,
              fontWeight: FontWeight.w500,
              textSize: 13,
            )),
            if (settingsEntity.widget != null) ...[
              settingsEntity.widget!,
              12.horizontalSpace,

            ],
            Rotate(
                child: SvgPicture.asset(
              Assets.icons.arrowForward,
              colorFilter: ThemeHelper().setUpIconsColor(context: context),
            )),
          ],
        ),
      ),
    );
  }
}
