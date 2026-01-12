import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/image_picker/app_image.dart';

class EmptyCartDesign extends StatelessWidget {
  const EmptyCartDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.bodyHeight * 0.1),
        Padding(
          padding: EdgeInsets.all(SizeConfig.bodyHeight * .12),
          child: AppImage.asset(
            Assets.images.emptyCart.path,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * .1,
          ),
          child: AppText(
            text: context.localizations.noCart,
            maxLines: 2,
            textSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
