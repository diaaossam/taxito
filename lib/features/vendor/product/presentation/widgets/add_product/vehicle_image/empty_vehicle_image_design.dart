import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';

import '../../../../../../../widgets/image_picker/app_image.dart';

class EmptyVehicleImageDesign extends StatelessWidget {
  final int length;

  const EmptyVehicleImageDesign({super.key, required this.length});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          length,
          (index) => Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              height: SizeConfig.bodyHeight * .08,
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.colorScheme.outline,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  width: 2,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Center(child: AppImage.asset(Assets.icons.documentUpload)),
            ),
          ),
        ),
      ],
    );
  }
}
