import 'package:flutter/material.dart';
import 'package:kardone/res/theme/theme_color.dart';

class SettingItem {
  ThemeData theme;
  ThemeColor themeColor;
  TextDirection layoutDirection;

  SettingItem({required this.theme, required this.layoutDirection, required this.themeColor});
}
