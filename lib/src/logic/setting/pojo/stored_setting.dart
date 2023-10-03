import 'package:flutter/material.dart';
import 'package:kardone/res/theme/theme_color.dart';
import 'package:kardone/res/theme/themes.dart';
import 'package:kardone/src/model/pref/pref_manager.dart';

import 'setting_item.dart';

class StoredSetting {
  final PrefManager _prefManager;

  StoredSetting(this._prefManager);

  Future<void> setSetting(SettingItem settingItem) async {
    await _setTheme(settingItem.theme == Themes.dark);
    await _setLayoutDirection(settingItem.layoutDirection);
    return Future.value();
  }

  Future<SettingItem> getSetting() async {
    var theme = await _getTheme();
    var layoutDirection = await _getLayoutDirection();
    return Future.value(
        SettingItem(theme: theme, layoutDirection: layoutDirection, themeColor: lightThemeColors));
  }

  Future<void> _setTheme(bool dark) async {
    await _prefManager.setTheme(dark);
    return Future.value();
  }

  Future<ThemeData> _getTheme() async {
    return await _prefManager.getTheme();
  }

  Future<void> _setLayoutDirection(TextDirection textDirection) async {
    await _prefManager.setLayoutDirection(textDirection == TextDirection.rtl);
    return Future.value();
  }

  Future<TextDirection> _getLayoutDirection() async {
    return await _prefManager.getLayoutDirection();
  }
}
