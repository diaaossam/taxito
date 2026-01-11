import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/enum/trip_status_enum.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../data/models/trip_model.dart';
import '../trip_distance_info.dart';

class TripInfoWidget extends StatelessWidget {
  final TripModel tripModel;

  const TripInfoWidget({super.key, required this.tripModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: SizeConfig.bodyHeight*.03,),
        Row(
          children: [
            AppImage.asset(
              Assets.images.from.path,
              height: 25,
              width: 25,
            ),
            8.horizontalSpace,
            Expanded(
              child: AppText(
                textSize: 12,
                text:
                "${context.localizations.from} : ${tripModel.from?.address}",
                maxLines: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.bodyHeight*.03,),
        Row(
          children: [
            AppImage.asset(
              Assets.images.to.path,
              height: 25,
              width: 25,
            ),
            8.horizontalSpace,
            Expanded(
              child: AppText(
                textSize: 12,
                text:
                "${context.localizations.to} : ${tripModel.to?.address}",
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

