import 'package:flutter/material.dart';
import 'package:kardone/res/theme/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  final String THEME = "THEME";
  final String LAYOUT_DIRECTION = "LAYOUT_DIRECTION";
  final String ME_KEY = "ME_KEY";
  final String SelectedLangID = "SelectedLangID";

  static final PrefManager _singleton = PrefManager._internal();

  factory PrefManager() {
    return _singleton;
  }

  PrefManager._internal();

  SharedPreferences? _prefs;

  _initPref() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setTheme(bool isDark) async {
    await _initPref();
    await _prefs!.setBool(THEME, isDark);
  }

  Future<ThemeData> getTheme() async {
    bool isDarkTheme = _prefs!.getBool(THEME) ?? true;
    return isDarkTheme ? Themes.dark : Themes.light;
  }

  Future<void> setLayoutDirection(bool isRtl) async {
    await _initPref();
    await _prefs!.setBool(LAYOUT_DIRECTION, isRtl);
  }

  Future<TextDirection> getLayoutDirection() async {
    bool isRtl = _prefs!.getBool(LAYOUT_DIRECTION) ?? true;
    return isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  Future<bool> clear() async {
    await _initPref();
    return _prefs!.clear();
  }
}
