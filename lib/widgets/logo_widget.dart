import 'package:flutter/material.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';

class LogoWidget extends StatelessWidget {
  final bool isWithText;
  final double? size;

  const LogoWidget({super.key, this.isWithText = true, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImage.asset(
            Assets.images.logoCirclure.path,
            height: size ?? SizeConfig.bodyHeight * .4,
            width: size ?? SizeConfig.bodyHeight * .4,
          ),
        ],
      ),
    );
  }
}
