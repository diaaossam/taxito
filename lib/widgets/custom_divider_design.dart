import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/color_extensions.dart';

import '../core/utils/app_size.dart';


class CustomDividerDesign extends StatelessWidget {
  const CustomDividerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.outline,
      width: SizeConfig.screenWidth,
      height: 1,
    );
  }
}
