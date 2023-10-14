import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'applic.dart';

class Translations {
  static Translations? _singleton;

  static Translations init(Locale locale) {
    _singleton = Translations._internal(locale);
    return _singleton!;
  }

  static Translations instance() {
    return _singleton ?? init(APPLIC().supportedLocales.call().first);
  }

  Translations._internal(this.locale);

  Locale locale;
  Map<dynamic, dynamic> _localizedValues = {};

  String text(String? key) {
    return _localizedValues[key] ?? '';
  }

  Future<Translations> load(Locale locale) async {
    this.locale = locale;
    String jsonContent = await rootBundle.loadString("i18n/${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return this;
  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => applic.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.instance().load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) => Translations.instance().load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}
