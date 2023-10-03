import 'package:flutter/material.dart';

import 'theme_color.dart';

class Themes {
  static ThemeData light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      lightThemeColors,
    ],
  );

  static ThemeData dark = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      darkThemeColors
    ],
  );

}
