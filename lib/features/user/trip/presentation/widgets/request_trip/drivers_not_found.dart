import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:flutter/material.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/image_picker/app_image.dart';

class DriversNotFound extends StatelessWidget {
  final TripModel tripModel;

  const DriversNotFound({super.key, required this.tripModel});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: SizeConfig.bodyHeight * .08),
            AppImage.asset(
              Assets.images.searchingForDriver.path,
              height: SizeConfig.bodyHeight * .2,
              width: SizeConfig.bodyHeight * .2,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .04),
            AppText(
              text: tripModel.cancelReason?.title ?? "",
              fontWeight: FontWeight.w600,
              textSize: 18,
            ),
            const Spacer(),
            Padding(
              padding: screenPadding(),
              child: CustomButton(
                text: context.localizations.home,
                press: () {
                  context.navigateToAndFinish(const MainLayout());
                },
                backgroundColor: Colors.transparent,
                textColor: context.colorScheme.primary,
              ),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .04),
          ],
        ),
      ),
    );
  }
}
