import 'package:taxito/config/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? textSize;
  final double? textHeight;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextAlign? align;
  final int? maxLines;
  final String? fontFamily;
  final bool? isLogo;
  final bool isHint;

  const AppText({
    super.key,
    required this.text,
    this.color,
    this.textSize,
    this.fontWeight,
    this.maxLines,
    this.textDecoration,
    this.textHeight = 1.2,
    this.fontFamily,
    this.align,
    this.isLogo = false,
    this.isHint = false,
  });

  const AppText.hint(
      {super.key,
      required this.text,
      Color hintColor = Colors.grey,
      this.textSize,
      this.fontWeight,
      this.maxLines,
      this.textDecoration,
      this.textHeight = 1.2,
      this.fontFamily,
      this.align,
      this.isHint = true})
      : color = hintColor,
        isLogo = false;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      textScaler: const TextScaler.linear(0.9),
      style: ThemeHelper().appTextStyle(
          context: context,
          fontFamily: fontFamily,
          hintColor: isHint ? color : null,
          color: color,
          fontWeight: fontWeight,
          textDecoration: textDecoration,
          textHeight: textHeight ?? 1.2,
          textSize: textSize),
    );
  }
}
