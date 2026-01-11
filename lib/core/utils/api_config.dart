import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taxito/core/enum/language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/captain/delivery_order/data/models/response/my_address.dart';
import 'app_strings.dart';

class ApiConfig {
  static late Language? language;
  static late bool? isGuest;
  static late ThemeMode? themeMode;
  static late MyAddress? myAddress;

  Future<void> init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isGuest = sharedPreferences.getBool(AppStrings.isGuest) ?? true;

    String mode =
        sharedPreferences.getString(AppStrings.theme) ?? AppStrings.light;
    String stringLanguage =
        sharedPreferences.getString(AppStrings.locale) ?? AppStrings.arabicCode;
    language = handleLanguageByString(code: stringLanguage);
    themeMode = mode == AppStrings.light ? ThemeMode.light : ThemeMode.dark;

    String? location = sharedPreferences.getString(AppStrings.location);
    if (location != null) {
      myAddress = MyAddress.fromJson(json.decode(location));
    } else {
      myAddress = null;
    }
  }

  Future<void> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
