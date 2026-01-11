import 'package:flutter/material.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/widgets/app_text.dart';

class LanguageItemDesign extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback callback;

  const LanguageItemDesign(
      {super.key,
      required this.language,
      required this.isSelected,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * .04,
            vertical: SizeConfig.bodyHeight * .025),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 2,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.outline)),
        child: Row(
          children: [
            AppText(
              text: language,
              fontWeight: FontWeight.w500,
              textSize: 13,
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: context.colorScheme.primary,
              )
          ],
        ),
      ),
    );
  }
}
