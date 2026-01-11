import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxito/config/theme/theme_helper.dart';
import 'package:taxito/core/enum/language.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_scheme.dart';

class ThemeManger {
  static ThemeData appTheme({required Language language}) => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColorScheme.light.background,
        textTheme: TextTheme(
            bodyMedium: TextStyle(color: AppColorScheme.light.onSurface),
            headlineMedium: TextStyle(color: AppColorScheme.light.shadow)),
        appBarTheme: AppBarTheme(
            backgroundColor: AppColorScheme.light.background,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: AppColorScheme.light.shadow,
            ),
            actionsIconTheme: IconThemeData(
              color: AppColorScheme.light.shadow,
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white)),
        fontFamily: language == Language.english
            ? AppStrings.englishFont
            : AppStrings.arabicFont,
        inputDecorationTheme: InputDecorationTheme(
          border: ThemeHelper().buildBorder(),
          enabledBorder: ThemeHelper().buildBorder(),
          disabledBorder: ThemeHelper().buildBorder(),
          focusedBorder: ThemeHelper().buildBorder(),
          errorBorder: ThemeHelper().buildBorder(),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColorScheme.light.primary,
                fontSize: 12),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColorScheme.light.shadow,
                fontSize: 12),
            selectedItemColor: AppColorScheme.light.primary,
            unselectedItemColor: AppColorScheme.light.surface),
        checkboxTheme:
            CheckboxThemeData(fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColorScheme
                .light.primary; // the color when checkbox is selected;
          }
          return Colors.transparent;
        })),
        primaryColor: AppColorScheme.light.primary,
        colorScheme: AppColorScheme.light,
      );

  static ThemeData blackTheme({required Language language}) => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColorScheme.light.surface,
        textTheme: TextTheme(
            bodyMedium: TextStyle(color: AppColorScheme.light.onSurface),
            headlineMedium: TextStyle(color: AppColorScheme.light.shadow)),
        appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: AppColorScheme.light.surface,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: AppColorScheme.light.shadow,
            ),
            actionsIconTheme: IconThemeData(
              color: AppColorScheme.light.shadow,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
                statusBarColor: AppColorScheme.dark.surface)),
        fontFamily: language == Language.english
            ? AppStrings.englishFont
            : AppStrings.arabicFont,
        inputDecorationTheme: InputDecorationTheme(
          border: ThemeHelper().buildBorder(),
          enabledBorder: ThemeHelper().buildBorder(),
          disabledBorder: ThemeHelper().buildBorder(),
          focusedBorder: ThemeHelper().buildBorder(),
          errorBorder: ThemeHelper().buildBorder(),
        ),
        primaryColor: AppColorScheme.dark.primary,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 5.0,
            backgroundColor: AppColorScheme.dark.surface,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColorScheme.dark.primary,
            unselectedItemColor: AppColorScheme.dark.surface),
        colorScheme: AppColorScheme.dark,
        checkboxTheme:
            CheckboxThemeData(fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColorScheme
                .light.primary; // the color when checkbox is selected;
          }
          return Colors.transparent;
        })),
      );
}
