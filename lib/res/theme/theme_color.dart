import 'package:ToDo/res/color.dart';
import 'package:flutter/material.dart';

class ThemeColor extends ThemeExtension<ThemeColor> {
  Color iconGreen;
  Color iconPurple;
  Color iconPink;
  Color iconBlue;
  Color iconRed;
  Color iconDeepBlue;
  Color iconGray;
  Color primaryText;
  Color secondaryText;
  Color disableColor;
  Color borderColor;
  Color itemFillColor;
  Color shadowColor;
  Color pageBackground;
  Color onBackground;
  Color primaryColor;
  Color accentColor;
  Color accentLiteColor;
  Color textOnAccentColor;
  Color navigationColor;

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
    required this.pageBackground,
    required this.onBackground,
    required this.primaryColor,
    required this.accentColor,
    required this.iconRed,
    required this.accentLiteColor,
    required this.textOnAccentColor,
    required this.navigationColor,
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
    Color? iconRed,
    Color? itemFillColor,
    Color? shadowColor,
    Color? pageBackground,
    Color? onBackground,
    Color? primaryColor,
    Color? accentColor,
    Color? accentLiteColor,
    Color? textOnAccentColor,
    Color? navigationColor,
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
        pageBackground: pageBackground ?? this.pageBackground,
        onBackground: onBackground ?? this.onBackground,
        primaryColor: primaryColor ?? this.primaryColor,
        accentColor: accentColor ?? this.accentColor,
        accentLiteColor: accentLiteColor ?? this.accentLiteColor,
        iconRed: iconRed ?? this.iconRed,
        textOnAccentColor: textOnAccentColor ?? this.textOnAccentColor,
        navigationColor: navigationColor ?? this.navigationColor,
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
      pageBackground: Color.lerp(pageBackground, other.pageBackground, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      accentLiteColor: Color.lerp(accentLiteColor, other.accentLiteColor, t)!,
      navigationColor: Color.lerp(navigationColor, other.navigationColor, t)!,
      iconRed: Color.lerp(iconRed, other.iconRed, t)!,
      textOnAccentColor: Color.lerp(textOnAccentColor, other.textOnAccentColor, t)!,
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
    pageBackground: UiColors.pageBackground,
    onBackground: UiColors.whiteBackground,
    primaryColor: UiColors.green,
    accentColor: UiColors.orange,
    accentLiteColor: UiColors.orangeLite,
    iconRed: UiColors.iconRed,
    textOnAccentColor: UiColors.whiteBackground,
    navigationColor: UiColors.liteBackground,
    iconGray: UiColors.iconGray);

ThemeColor darkThemeColors = ThemeColor(
    iconBlue: UiColors.iconBlueDark,
    disableColor: UiColors.disableColorDark,
    primaryText: UiColors.primaryTextDark,
    secondaryText: UiColors.secondaryTextDark,
    iconGreen: UiColors.iconGreenDark,
    iconPurple: UiColors.iconPurpleDark,
    iconPink: UiColors.iconPinkDark,
    iconDeepBlue: UiColors.iconDeepBlueDark,
    borderColor: UiColors.borderColorDark,
    itemFillColor: UiColors.itemFillColorDark,
    shadowColor: UiColors.shadowColorDark,
    pageBackground: UiColors.pageBackgroundDark,
    onBackground: UiColors.whiteBackgroundDark,
    primaryColor: UiColors.greenDark,
    iconRed: UiColors.iconRedDark,
    accentColor: UiColors.orangeDark,
    accentLiteColor: UiColors.orangeLiteDark,
    textOnAccentColor: UiColors.whiteBackground,
    navigationColor: UiColors.liteBackgroundDark,
    iconGray: UiColors.iconGrayDark);
