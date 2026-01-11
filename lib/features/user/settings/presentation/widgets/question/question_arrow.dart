import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/gen/assets.gen.dart';

class QuestionArrowWidget extends StatelessWidget {
  final bool isActive;

  const QuestionArrowWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.bodyHeight * .06,
      width: SizeConfig.bodyHeight * .06,
      padding: const EdgeInsets.all(12),
      child: SvgPicture.asset(
          isActive ? Assets.icons.arrowTop : Assets.icons.arrowDown),
    );
  }
}
