import 'package:flutter/material.dart';

import '../color.dart';
import 'theme_color.dart';

class Themes {
  static ThemeData light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      ThemeColor(
          iconBlue: UiColors.iconBlue,
          disableColor: UiColors.disableColor,
          primaryText: UiColors.primaryText,
          secondaryText: UiColors.secondaryText,
          iconGreen: UiColors.iconGreen,
          iconPurple: UiColors.iconPurple,
          iconPink: UiColors.iconPink,
          iconDeepBlue: UiColors.iconDeepBlue,
          iconGray: UiColors.iconGray),
    ],
  );

  static ThemeData dark = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      ThemeColor(
          iconBlue: UiColors.iconBlue,
          disableColor: UiColors.disableColor,
          primaryText: UiColors.primaryText,
          secondaryText: UiColors.secondaryText,
          iconGreen: UiColors.iconGreen,
          iconPurple: UiColors.iconPurple,
          iconPink: UiColors.iconPink,
          iconDeepBlue: UiColors.iconDeepBlue,
          iconGray: UiColors.iconGray),
    ],
  );
}
