import 'package:ToDo/applic.dart';
import 'package:ToDo/res/styles/theme/theme_color.dart';
import 'package:ToDo/src/base/navigation_service.dart';
import 'package:flutter/material.dart';

ThemeColor getSelectedThemeColors() {
  return Theme.of(NavigationService.navigatorKey.currentContext!)
      .extension<ThemeColor>()!;
}

bool isDark() {
  return APPLIC.currentThemeIsDark;
}
