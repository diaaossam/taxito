import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/api_config.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:aslol/features/location/location_helper.dart';
import 'package:aslol/features/settings/settings_helper.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLocationPicker extends StatefulWidget {
  final Function (MyAddress) onChangeLocation;
  const CustomLocationPicker({super.key, required this.onChangeLocation});

  @override
  State<CustomLocationPicker> createState() => _CustomLocationPickerState();
}

class _CustomLocationPickerState extends State<CustomLocationPicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(ApiConfig.isGuest == true){
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
          SizedBox(
            width: SizeConfig.screenWidth * .1,
          ),
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
          )
        ],
      ),
    );
  }
}
