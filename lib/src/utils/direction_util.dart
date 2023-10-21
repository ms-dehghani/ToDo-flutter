import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:kardone/translations.dart';

bool isRTL({Locale? locale}) {
  locale ??= Translations.instance().locale;
  return intl.Bidi.isRtlLanguage(locale.languageCode);
}

TextDirection getDirection(){
  return isRTL() ? TextDirection.rtl : TextDirection.ltr;
}
