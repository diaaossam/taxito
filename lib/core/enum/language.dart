import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';

enum Language {
  arabic("ar"),
  english("en"),
  kurdishSorani("ku"),
  kurdishBehdini("fa");

  final String name;

  const Language(this.name);
}

Language handleLanguageByString({required String code}) {
  if (code == "ar") {
    return Language.arabic;
  } else if (code == "en") {
    return Language.english;
  } else if (code == "ku") {
    return Language.kurdishSorani;
  } else {
    return Language.kurdishBehdini;
  }
}

String handleLanguageToString(
    {required BuildContext context, required String code}) {
  if (code == "ar") {
    return context.localizations.arabic;
  } else if (code == "en") {
    return context.localizations.english;
  } else {
    return context.localizations.english;
  }
}
