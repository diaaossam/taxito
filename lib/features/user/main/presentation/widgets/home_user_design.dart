import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/data/models/user_model_helper.dart';
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
      onTap: () => LocationHelper().showLocationDailog(
        context: context,
        myAddress: (p0) {},
      ),
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
            child: Image.network(
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
                AppText(
                  text: UserDataService().getUserData()!.name.toString(),
                  fontWeight: FontWeight.w600,
                  textSize: 12,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .005),
                LocationInfoWidget(onLocationSelected: (data) {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
