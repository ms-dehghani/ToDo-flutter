import 'package:ToDo/applic.dart';
import 'package:ToDo/res/theme/theme_color.dart';
import 'package:flutter/material.dart';

ThemeColor getSelectedThemeColors(BuildContext context) {
  return Theme.of(context).extension<ThemeColor>()!;
  return APPLIC.currentThemeIsDark ? darkThemeColors : lightThemeColors;
}

bool isDark() {
  return APPLIC.currentThemeIsDark;
}
