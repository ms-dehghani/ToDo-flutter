import 'package:flutter/material.dart';

class ThemeColor extends ThemeExtension<ThemeColor> {
  Color iconGreen;
  Color iconPurple;
  Color iconPink;
  Color iconBlue;
  Color iconDeepBlue;
  Color iconGray;
  Color primaryText;
  Color secondaryText;
  Color disableColor;

  ThemeColor({
    required this.iconBlue,
    required this.disableColor,
    required this.primaryText,
    required this.secondaryText,
    required this.iconGreen,
    required this.iconPurple,
    required this.iconPink,
    required this.iconDeepBlue,
    required this.iconGray,
  });

  @override
  ThemeExtension<ThemeColor> copyWith({
    Color? iconBlue,
    Color? disableColor,
    Color? primaryText,
    Color? secondaryText,
    Color? iconGreen,
    Color? iconPurple,
    Color? iconPink,
    Color? iconDeepBlue,
    Color? iconGray,
  }) {
    return ThemeColor(
        iconBlue: iconBlue ?? this.iconBlue,
        disableColor: disableColor ?? this.disableColor,
        primaryText: primaryText ?? this.primaryText,
        iconGreen: iconGreen ?? this.iconGreen,
        secondaryText: secondaryText ?? this.secondaryText,
        iconPurple: iconPurple ?? this.iconPurple,
        iconPink: iconPink ?? this.iconPink,
        iconDeepBlue: iconDeepBlue ?? this.iconDeepBlue,
        iconGray: iconGray ?? this.iconGray);
  }

  @override
  ThemeExtension<ThemeColor> lerp(covariant ThemeExtension<ThemeColor>? other, double t) {
    if (other is! ThemeColor) {
      return this;
    }
    return ThemeColor(
      iconBlue: Color.lerp(iconBlue, other.iconBlue, t)!,
      disableColor: Color.lerp(disableColor, other.disableColor, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      iconGreen: Color.lerp(iconGreen, other.iconGreen, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      iconPurple: Color.lerp(iconPurple, other.iconPurple, t)!,
      iconPink: Color.lerp(iconPink, other.iconPink, t)!,
      iconDeepBlue: Color.lerp(iconDeepBlue, other.iconDeepBlue, t)!,
      iconGray: Color.lerp(iconGray, other.iconGray, t)!,
    );
  }


}
