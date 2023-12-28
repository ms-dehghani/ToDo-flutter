import 'package:ToDo/applic.dart';
import 'package:ToDo/res/theme/theme_color.dart';

ThemeColor getSelectedThemeColors() {
  return APPLIC.currentThemeIsDark ? darkThemeColors : lightThemeColors;
}

bool isDark() {
  return APPLIC.currentThemeIsDark;
}
