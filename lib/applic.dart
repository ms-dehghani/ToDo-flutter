import 'dart:ui';

import 'translations.dart';

typedef void LocaleChangeCallback(Locale locale);

class APPLIC {
  final List<String> supportedLanguages = ['en', 'fa'];

  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => Locale(lang, ''));
  LocaleChangeCallback? onLocaleChanged;

  static final APPLIC _applic = APPLIC._internal();

  factory APPLIC() {
    return _applic;
  }

  APPLIC._internal();

  static void changeLang(String? text) {
    Translations.instance().load(Locale(text ?? "en"));
  }
}

APPLIC applic = APPLIC();
