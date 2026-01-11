import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/app_image.dart';

class EmptyTripsHistoryWidget extends StatelessWidget {
  const EmptyTripsHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.bodyHeight * .2,
          ),
          AppImage.asset(
            Assets.icons.tripHistory,
            color: Colors.black,
            height: SizeConfig.bodyHeight * .2,
            width: 100,
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .04,
          ),
          AppText(
            text: context.localizations.noTrips,
            textSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
