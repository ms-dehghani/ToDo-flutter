import 'package:flutter/material.dart';

import 'dimens.dart';
import 'fonts.dart';

class TextStyles {
  static const TextStyle raleway =
      TextStyle(fontFamily: 'Iran', fontWeight: FontWeight.w400 ,decoration: TextDecoration
          .none);

  static TextStyle get h1 => raleway.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s20,
        letterSpacing: -1,
      );

  static TextStyle get h1Bold => raleway.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s20,
        letterSpacing: -1,
      );

  static TextStyle get h2 => h1.copyWith(fontSize: FontSizes.s16, letterSpacing: -.5);

  static TextStyle get h2Bold => h1Bold.copyWith(fontSize: FontSizes.s16, letterSpacing: -.5);

  static TextStyle get h3 => h1.copyWith(fontSize: FontSizes.s14, letterSpacing: -.05);

  static TextStyle get h3Bold => h2Bold.copyWith(fontSize: FontSizes.s14, letterSpacing: -.05);

  static TextStyle get h4 => h1.copyWith(fontSize: FontSizes.s10, letterSpacing: -.05);

  static TextStyle get h4Bold => h2Bold.copyWith(fontSize: FontSizes.s10, letterSpacing: -.05);

}
