import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/main/presentation/pages/main_layout.dart';
import 'package:aslol/features/order/presentation/pages/track_order.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessOrderScreen extends StatelessWidget {
  final num id;
  const SuccessOrderScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: screenPadding(),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .3,
                ),
                AppImage.asset(
                  Assets.images.successOrder.path,
                  height: SizeConfig.bodyHeight * .3,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                AppText(
                  text: context.localizations.orderSuccess,
                  fontWeight: FontWeight.w600,
                  textSize: 16,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
                AppText.hint(
                  text: context.localizations.orderSuccessHint,
                  textSize: 13,
                  maxLines: 2,
                ),
                const Spacer(),
                CustomButton(
                    text: context.localizations.trackOrder, press: () => context.navigateTo(TrackOrderScreen(id: id))),
                15.verticalSpace,
                CustomButton(
                  text: context.localizations.backShopping,
                  press: () => context.navigateToAndFinish(const MainLayout()),
                  backgroundColor: Colors.transparent,
                  textColor: context.colorScheme.onSurface,
                  borderColor: context.colorScheme.onSurface,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
