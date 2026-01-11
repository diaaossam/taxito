import 'package:flutter/material.dart';

class SizeConfig {
  late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double statusBarHeight;
  static late String langCode;
  late double appBarHeight;
  static late double bodyHeight;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    statusBarHeight = mediaQueryData.padding.top;
    appBarHeight = AppBar().preferredSize.height;
    bodyHeight = mediaQueryData.size.height - statusBarHeight - appBarHeight;
    langCode = Localizations.localeOf(context).languageCode;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.bodyHeight;
  return (inputHeight / 812.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}

EdgeInsetsGeometry screenPadding({double ? padding}) {
  return EdgeInsets.symmetric(horizontal: padding ??SizeConfig.screenWidth * .04  );
}
