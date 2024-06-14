import 'package:flutter/material.dart';

import 'insets.dart';

class Corners {
  static const double sm = 3;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);

  static const double med = 5;
  static const BorderRadius medBorder = BorderRadius.all(medRadius);
  static const Radius medRadius = Radius.circular(med);

  static const double lg = 8;
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const Radius lgRadius = Radius.circular(lg);

  static const double hg = 12;
  static const BorderRadius hgBorder = BorderRadius.all(hgRadius);
  static const BorderRadius hgTopBorder =
      BorderRadius.only(topLeft: hgRadius, topRight: hgRadius);
  static const Radius hgRadius = Radius.circular(hg);

  static const double xxl = 24;
  static const BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static const Radius xxlRadius = Radius.circular(xxl);

  static BorderRadius bottomSheetTopBorder = BorderRadius.only(
      topLeft: Radius.circular(Insets.lg),
      topRight: Radius.circular(Insets.lg));

  static const double xxxl = 36;
  static const BorderRadius xxxlBorder = BorderRadius.all(xxxlRadius);
  static const Radius xxxlRadius = Radius.circular(xxxl);
}
