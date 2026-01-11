import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';

class AppDialogDesign extends StatelessWidget {
  final String? title;
  final String? acceptButton;
  final double? height;
  final String? cancelButton;
  final Function(bool) isAccept;

  final String? image;

  const AppDialogDesign({
      super.key,
      this.title,
      this.acceptButton,
      this.cancelButton,
      this.image,
      required this.isAccept,
      this.height});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: height ?? SizeConfig.bodyHeight * .4,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffF7F7F7),
                border: Border.all(
                  color: context.colorScheme.outline,
                ),
              ),
              child: AppImage.asset(
                image ?? Assets.icons.close,
                height: SizeConfig.bodyHeight * .03,
                color: context.colorScheme.error,
              ),
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * .04),
              child: AppText(
                text: title ?? "",
                maxLines: 5,
                align: TextAlign.center,
                textHeight: 1.5,
              ),
            ),
            const Spacer(),
            Padding(
              padding: screenPadding(),
              child: Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    text: context.localizations.yes,
                    press: () {
                      Navigator.pop(context);
                      isAccept(true);
                    },
                    height: 40.h,
                    backgroundColor: context.colorScheme.error,
                    borderColor: context.colorScheme.error,
                    textColor: Colors.white,
                  )),
                  20.horizontalSpace,
                  Expanded(
                      child: CustomButton(
                    text: context.localizations.no,
                    press: () {
                      Navigator.pop(context);
                      isAccept(false);
                    },
                    height: 40.h, textColor:  context.colorScheme.shadow,
                    borderColor: context.colorScheme.shadow,
                    backgroundColor: Colors.transparent,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
          ],
        ),
      ),
    );
  }
}
