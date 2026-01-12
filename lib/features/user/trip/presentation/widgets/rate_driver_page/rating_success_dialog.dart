import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/image_picker/app_image.dart';


class RatingSuccessDialog extends StatelessWidget {
  const RatingSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.bodyHeight * .6,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            height: SizeConfig.bodyHeight * .6,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .1,
                ),
                AppImage.asset(
                  Assets.icons.rating,
                  height: SizeConfig.bodyHeight * .2,
                  width: SizeConfig.bodyHeight * .2,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                AppText(
                  text: context.localizations.successRating,
                  maxLines: 3,
                  textSize: 15,
                  align: TextAlign.center,
                ),
                const Spacer(),
                CustomButton(
                    text: context.localizations.home,
                    press: () => context.navigateToAndFinish(const MainLayout())),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
