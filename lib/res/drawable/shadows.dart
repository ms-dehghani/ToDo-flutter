import 'package:flutter/material.dart';

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 10),
      ];

  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];

  static List<BoxShadow> get topAndBottom => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.10),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 0)),
      ];
}
