import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/location/location_helper.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../captain/delivery_order/data/models/response/my_address.dart';
import '../../../../captain/settings/settings_helper.dart';

class CustomLocationPicker extends StatefulWidget {
  final Function(MyAddress) onChangeLocation;

  const CustomLocationPicker({super.key, required this.onChangeLocation});

  @override
  State<CustomLocationPicker> createState() => _CustomLocationPickerState();
}

class _CustomLocationPickerState extends State<CustomLocationPicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (ApiConfig.isGuest == true) {
          SettingsHelper().showGuestDialog(context);
          return;
        }
        LocationHelper().showLocationDailog(
          context: context,
          myAddress: widget.onChangeLocation,
        );
      },
      child: Row(
        children: [
          SizedBox(width: SizeConfig.screenWidth * .1),
          AppImage.asset(Assets.icons.location2),
          10.horizontalSpace,
          Expanded(
            child: AppText(
              textSize: 12,
              fontWeight: FontWeight.w500,
              text: ApiConfig.myAddress != null
                  ? ApiConfig.myAddress?.name ?? ""
                  : context.localizations.currentLocation,
            ),
          ),
          10.horizontalSpace,
          AppImage.asset(
            Assets.icons.arrowDown,
            color: context.colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
