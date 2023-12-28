import 'dart:ui';

import 'package:ToDo/res/text_style.dart';

import 'translations.dart';

typedef void LocaleChangeCallback(Locale locale);
typedef void ThemeChangeCallback(bool isDark);

class APPLIC {
  final List<String> supportedLanguages = ['en', 'fa'];

  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => Locale(lang, ''));
  LocaleChangeCallback? onLocaleChanged;
  ThemeChangeCallback? onThemeChanged;

  static String currentLang = "";

  static final APPLIC _applic = APPLIC._internal();

  factory APPLIC() {
    return _applic;
  }

  APPLIC._internal();

  static void changeLang(String? text) {
    text ??= applic.supportedLanguages[0];
    if (text == currentLang) {
      return;
    }
    var selectedLocale = Locale(text);
    currentLang = selectedLocale.languageCode;
    Translations.instance().load(selectedLocale);
    textStyles.reloadStyles(selectedLocale);
    _applic.onLocaleChanged?.call(selectedLocale);
  }

  static void changeTheme(bool isDark) {
    _applic.onThemeChanged?.call(isDark);
  }
}

APPLIC applic = APPLIC();
