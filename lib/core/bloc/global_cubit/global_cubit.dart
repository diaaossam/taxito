import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/enum/language.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global_state.dart';

@Injectable()
class GlobalCubit extends Cubit<GlobalState> {
  final SharedPreferences sharedPreferences;

  GlobalCubit(this.sharedPreferences) : super(LocaleInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  Future<void> getAppSettings() async {
    final cachedLangCode = sharedPreferences.getString(AppStrings.locale);
    final cachedTheme = sharedPreferences.getString(AppStrings.theme);
    locale = Locale(cachedLangCode ?? AppStrings.arabicCode);
    language = handleLanguageByString(code: cachedLangCode ?? "ar");
    themeMode = cachedTheme != null
        ? cachedTheme == "light"
            ? ThemeMode.light
            : ThemeMode.dark
        : ThemeMode.light;
    emit(ChangeLocaleState());
  }

  ///////////////////////// App Lang ////////////////////////

  Locale locale = const Locale(AppStrings.arabicCode);
  Language language = Language.arabic;

  Future<void> changeLanguage({required Language lang}) async {
    sharedPreferences.setString(AppStrings.locale, lang.name);
    locale = Locale(lang.name);
    language = lang;
    emit(ChangeLocaleState());
  }

  //////////////////// Theme ///////////////////////

  ThemeMode themeMode = ThemeMode.light;

  void chooseAppTheme({required ThemeMode theme}) async {
    themeMode = theme;
    sharedPreferences.setString(AppStrings.theme, theme.name);
    emit(ChooseAppThemeState());
  }
}
