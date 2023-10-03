import 'package:flutter/material.dart';
import 'package:kardone/res/color.dart';
import 'package:kardone/res/theme/themes.dart';

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
  Color borderColor;
  Color itemFillColor;
  Color shadowColor;

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
    required this.borderColor,
    required this.itemFillColor,
    required this.shadowColor,
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
    Color? borderColor,
    Color? itemFillColor,
    Color? shadowColor,
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
        borderColor: borderColor ?? this.borderColor,
        itemFillColor: itemFillColor ?? this.itemFillColor,
        shadowColor: shadowColor ?? this.shadowColor,
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
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      itemFillColor: Color.lerp(itemFillColor, other.itemFillColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
    );
  }
}

ThemeColor lightThemeColors = ThemeColor(
    iconBlue: UiColors.iconBlue,
    disableColor: UiColors.disableColor,
    primaryText: UiColors.primaryText,
    secondaryText: UiColors.secondaryText,
    iconGreen: UiColors.iconGreen,
    iconPurple: UiColors.iconPurple,
    iconPink: UiColors.iconPink,
    iconDeepBlue: UiColors.iconDeepBlue,
    borderColor: UiColors.borderColor,
    itemFillColor: UiColors.itemFillColor,
    shadowColor: UiColors.shadowColor,
    iconGray: UiColors.iconGray);

ThemeColor darkThemeColors = ThemeColor(
    iconBlue: UiColors.iconBlue,
    disableColor: UiColors.disableColor,
    primaryText: UiColors.primaryText,
    secondaryText: UiColors.secondaryText,
    iconGreen: UiColors.iconGreen,
    iconPurple: UiColors.iconPurple,
    iconPink: UiColors.iconPink,
    iconDeepBlue: UiColors.iconDeepBlue,
    borderColor: UiColors.borderColor,
    itemFillColor: UiColors.itemFillColor,
    shadowColor: UiColors.shadowColor,
    iconGray: UiColors.iconGray);
