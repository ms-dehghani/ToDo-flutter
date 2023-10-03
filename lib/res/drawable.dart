import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/theme/theme_color.dart';

class Drawable {
  static BoxDecoration simpleBorder(ThemeColor color) => BoxDecoration(
      color: color.itemFillColor,
      borderRadius: Corners.medBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration itemDetailDecoration(ThemeColor color) => BoxDecoration(
      color: color.itemFillColor,
      boxShadow: Shadows.small);

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
