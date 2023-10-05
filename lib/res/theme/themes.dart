import 'package:flutter/material.dart';

import 'theme_color.dart';

class Themes {
  static ThemeData light = ThemeData.light().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    extensions: <ThemeExtension<dynamic>>[
      lightThemeColors,
    ],
  );

  static ThemeData dark = ThemeData.dark().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    extensions: <ThemeExtension<dynamic>>[
      darkThemeColors
    ],
  );

}
