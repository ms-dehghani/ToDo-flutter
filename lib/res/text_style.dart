import 'package:flutter/material.dart';

import 'dimens.dart';
import 'fonts.dart';

class TextStyles {
  static const TextStyle raleway =
      TextStyle(fontFamily: Fonts.raleway, fontWeight: FontWeight.w400, height: 1);

  static TextStyle get h1 => raleway.copyWith(
      fontWeight: FontWeight.w600, fontSize: FontSizes.s48, letterSpacing: -1, height: 1.17);

  static TextStyle get h2 => h1.copyWith(fontSize: FontSizes.s24, letterSpacing: -.5, height: 1.16);

  static TextStyle get h3 =>
      h1.copyWith(fontSize: FontSizes.s14, letterSpacing: -.05, height: 1.29);

  static TextStyle get title1 =>
      raleway.copyWith(fontWeight: FontWeight.bold, fontSize: FontSizes.s16, height: 1.31);

  static TextStyle get title2 =>
      title1.copyWith(fontWeight: FontWeight.w500, fontSize: FontSizes.s14, height: 1.36);

  static TextStyle get body1 =>
      raleway.copyWith(fontWeight: FontWeight.normal, fontSize: FontSizes.s14, height: 1.71);

  static TextStyle get body2 =>
      body1.copyWith(fontSize: FontSizes.s12, height: 1.5, letterSpacing: .2);

  static TextStyle get body3 =>
      body1.copyWith(fontSize: FontSizes.s12, height: 1.5, fontWeight: FontWeight.bold);

  static TextStyle get callout1 => raleway.copyWith(
      fontWeight: FontWeight.w800, fontSize: FontSizes.s12, height: 1.17, letterSpacing: .5);

  static TextStyle get callout2 =>
      callout1.copyWith(fontSize: FontSizes.s10, height: 1, letterSpacing: .25);

  static TextStyle get caption =>
      raleway.copyWith(fontWeight: FontWeight.w500, fontSize: FontSizes.s11, height: 1.36);
}
