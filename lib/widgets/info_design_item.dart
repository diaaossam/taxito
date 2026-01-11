import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoDesignItem extends StatelessWidget {
  final String icon, title;
  final double? iconSize, titleSize;

  const InfoDesignItem(
      {super.key,
      required this.icon,
      required this.title,
      this.iconSize,
      this.titleSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppImage.asset(
          icon,
          size: iconSize ?? 18,
        ),
        5.horizontalSpace,
        AppText(
          text: title,
          textSize: 12,
        ),
      ],
    );
  }
}
