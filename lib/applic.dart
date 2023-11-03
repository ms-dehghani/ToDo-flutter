import 'dart:ui';

import 'package:ToDo/res/text_style.dart';

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
    var selectedLocale = Locale(text ?? applic.supportedLanguages[0]);
    Translations.instance().load(selectedLocale);
    textStyles.reloadStyles(selectedLocale);
    _applic.onLocaleChanged?.call(selectedLocale);
  }
}

APPLIC applic = APPLIC();
