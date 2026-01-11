abstract class GlobalState {}

class ChangeLocaleState extends GlobalState {}

class ToggleLocaleState extends GlobalState {
  final int index;

  ToggleLocaleState({required this.index});
}

class ChangeLocaleState2 extends GlobalState {}

class LocaleInitial extends GlobalState {}

class ChangeAppTheme extends GlobalState {}

class LastPageViewState extends GlobalState {}

class ChooseAppLangState extends GlobalState {}

class ChooseAppAdvertState extends GlobalState {}

class ChooseAppThemeState extends GlobalState {}

class CacheAppDataSuccessState extends GlobalState {}

class CacheAppDataLoadingState extends GlobalState {}

class SaveLangPageState extends GlobalState {}

class GetCachedAppThemeState extends GlobalState {}

class SystemThemeState extends GlobalState {}
