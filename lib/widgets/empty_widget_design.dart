import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/core/utils/app_size.dart';

import 'app_text.dart';
import 'image_picker/app_image.dart';

class EmptyWidgetDesign extends StatelessWidget {
  final String msg;
  final String image;

  const EmptyWidgetDesign({
    super.key,
    required this.msg,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage.asset(
              image,
              height: SizeConfig.bodyHeight * .25,
            ),
            30.verticalSpace,
            AppText(
              text: msg,
              textSize: 18,
            ),
            80.verticalSpace,
          ],
        ),
      ),
    );
  }
}
