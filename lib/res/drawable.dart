import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/color.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/theme/theme_color.dart';

class Drawable {
  static BoxDecoration simpleRoundCorner(Color color) => BoxDecoration(
        color: color,
        borderRadius: Corners.lgBorder,
      );

  static BoxDecoration simpleBorder(ThemeColor color) => BoxDecoration(
      color: color.itemFillColor,
      borderRadius: Corners.medBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration calendarItemBorder(ThemeColor color) => BoxDecoration(
      color: color.itemFillColor,
      borderRadius: Corners.xxlBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration taskActionsDecoration(ThemeColor color) => BoxDecoration(
      color: UiColors.liteBackground,
      borderRadius: Corners.xxxlBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration backButtonDecoration(ThemeColor color) => BoxDecoration(
      color: UiColors.liteBackground,
      borderRadius: Corners.hgBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));


  static BoxDecoration dotedBorderDecoration(ThemeColor color) => BoxDecoration(
      color: UiColors.iconGreen.withOpacity(0.2),
      borderRadius: Corners.hgBorder,);

  static BoxDecoration itemDetailDecoration(ThemeColor color) =>
      BoxDecoration(color: color.itemFillColor, boxShadow: Shadows.small);
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(color: const Color(0xff333333).withOpacity(.15), spreadRadius: 0, blurRadius: 10),
      ];

  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];
}
