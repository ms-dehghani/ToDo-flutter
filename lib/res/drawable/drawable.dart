import 'package:ToDo/res/color/color.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dimens/corners.dart';
import '../dimens/strokes.dart';
import '../styles/theme/theme_color.dart';
import 'shadows.dart';

class Drawable {
  static BoxDecoration simpleRoundCorner(Color color) => BoxDecoration(
        color: color,
        borderRadius: Corners.lgBorder,
      );

  static BoxDecoration simpleBorder(ThemeColor color) => BoxDecoration(
      color: isDark() ? color.onBackground : color.itemFillColor,
      borderRadius: Corners.hgBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration calendarItemBorder(ThemeColor color) => BoxDecoration(
      color: color.itemFillColor,
      borderRadius: Corners.xxlBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration topRoundDecoration(Color color) => BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topRight: Corners.xxlRadius,
          topLeft: Corners.xxlRadius,
        ),
      );

  static BoxDecoration bottomSheetDecoration(Color color) => BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topRight: Corners.xxlRadius,
          topLeft: Corners.xxlRadius,
        ),
      );

  static BoxDecoration taskActionsDecoration(ThemeColor color) => BoxDecoration(
      color: isDark() ? color.onBackground : color.itemFillColor,
      borderRadius: Corners.xxxlBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration backButtonDecoration(ThemeColor color) => BoxDecoration(
      color: color.onBackground,
      borderRadius: Corners.hgBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration dotedBorderDecoration(ThemeColor color) => BoxDecoration(
        color: UiColors.iconGreen.withOpacity(0.2),
        borderRadius: Corners.hgBorder,
      );

  static BoxDecoration itemDetailDecoration(ThemeColor color) => BoxDecoration(
      color: isDark() ? color.onBackground : color.itemFillColor,
      boxShadow: Shadows.small);

  static BoxDecoration timeAndDatePickerBackItemDecoration(ThemeColor color) =>
      BoxDecoration(
          shape: BoxShape.rectangle,
          color: color.itemFillColor,
          borderRadius: Corners.hgBorder,
          border: Border.all(
            color: color.primaryColor,
            width: 1.0,
          ));
}
