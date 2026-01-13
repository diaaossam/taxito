import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/data/models/trip_model.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../../../captain/settings/settings_helper.dart';
import '../../../../chat/presentation/pages/message_screen.dart';

class ComminucationWithDriverWidget extends StatelessWidget {
  final TripModel tripModel;
  final Function(dynamic) onCallBack;

  const ComminucationWithDriverWidget({
    super.key,
    required this.tripModel,
    required this.onCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => SettingsHelper.contactUsWithPhoneNumber(
            phoneNumber: tripModel.driver?.phone ?? "",
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: context.colorScheme.outline),
              ),
              padding: const EdgeInsets.all(4),
              child: AppImage.asset(Assets.icons.callTrip, size: 22),
            ),
          ),
        ),
        4.horizontalSpace,
        GestureDetector(
          onTap: () => context.navigateTo(
            MessageScreen(tripModel: tripModel),
            callback: onCallBack,
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: context.colorScheme.outline),
              ),
              padding: const EdgeInsets.all(4),
              child: AppImage.asset(Assets.icons.messageText, size: 22),
            ),
          ),
        ),
        4.horizontalSpace,
        GestureDetector(
          onTap: () => SettingsHelper.contactUsWithWhatsApp(
            phoneNumber: tripModel.user?.phone ?? "",
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: context.colorScheme.outline),
              ),
              padding: const EdgeInsets.all(4),
              child: AppImage.asset(Assets.icons.logosWhatsappIcon, size: 22),
            ),
          ),
        ),
      ],
    );
  }
}
