import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';

import '../../../../../core/utils/api_config.dart';
import '../../../../captain/settings/settings_helper.dart';
import '../../../../common/models/user_model_helper.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../location/location_helper.dart';
import '../../../location/presentation/widgets/location_info_widget.dart';

class HomeUserDesign extends StatelessWidget {
  const HomeUserDesign({super.key});

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
        myAddress: (p0) {},
      );
      },
      child: Row(
        children: [
          8.horizontalSpace,
          Container(
            height: 40.h,
            width: 40.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            clipBehavior: Clip.antiAlias,
            child: ApiConfig.isGuest == true
                ? Image.asset(
                    Assets.images.logoCirclure.path,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        Assets.images.dummyUser.path,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.network(
                    UserDataService().getUserData()?.image ?? "",
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        Assets.images.dummyUser.path,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(ApiConfig.isGuest==true)...[
                  AppText(
                    text: context.localizations.guest,
                    fontWeight: FontWeight.w600,
                    textSize: 12,
                  ),
                ]else...[
                  AppText(
                    text: UserDataService().getUserData()!.name.toString(),
                    fontWeight: FontWeight.w600,
                    textSize: 12,
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * .005),
                  LocationInfoWidget(onLocationSelected: (data) {}),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
