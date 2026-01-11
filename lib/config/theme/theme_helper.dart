import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_strings.dart';

class ThemeHelper {
  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  OutlineInputBorder buildMainTffBorder({required BuildContext context}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: context.colorScheme.outline, width: 1),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    );
  }

  OutlineInputBorder buildErrorBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );
  }

  TextStyle customCategoryTextStyle(
          {required BuildContext context, double? size}) =>
      TextStyle(
        fontSize: size ?? 8.sp,
        fontWeight: FontWeight.w600,
        color: context.colorScheme.tertiary,
      );

  TextStyle mainTFFTextStyle(BuildContext context,
          {Color? color, bool isEnabled = true}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontFamily: AppStrings.arabicFont,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w500,
            color: color ?? context.colorScheme.onSurface,
            fontSize: 11.sp,
          );

  TextStyle hintTFFTextStyle({Color? color}) => TextStyle(
      color: color ?? const Color(0xffB0B0B0),
      fontSize: 12.sp,
      fontWeight: FontWeight.w400);

  TextStyle appTextStyle(
      {required BuildContext context,
      String? fontFamily,
      double textHeight = 1.2,
      TextDecoration? textDecoration,
      Color? color,
      Color? hintColor,
      FontWeight? fontWeight,
      double? textSize}) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontFamily: fontFamily,
          overflow: TextOverflow.ellipsis,
          height: textHeight,
          decoration: textDecoration,
          color: hintColor ??
              color ??
              Theme.of(context).textTheme.bodyMedium!.color,
          fontSize: _setUpSize(textSize: textSize),
          fontWeight: fontWeight ?? FontWeight.w400,
        );
  }

  double _setUpSize({double? textSize}) {
    return textSize != null ? textSize.sp : 13.sp;
  }

  ColorFilter? setUpIconsColor({required BuildContext context}) {
    if (ApiConfig.themeMode == ThemeMode.dark) {
      return ColorFilter.mode(context.colorScheme.onSurface, BlendMode.srcIn);
    }
    return null;
  }
}
