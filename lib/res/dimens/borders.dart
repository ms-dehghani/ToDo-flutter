import 'package:flutter/material.dart';

import 'corners.dart';
import 'strokes.dart';

class Borders {
  static RoundedRectangleBorder thinAndMedRadiosBorder(
          BuildContext context, Color borderColor) =>
      RoundedRectangleBorder(
          borderRadius: Corners.medBorder,
          side: thinBorder(context, borderColor));

  static RoundedRectangleBorder thinAndHighRadiosBorder(
          BuildContext context, Color borderColor) =>
      RoundedRectangleBorder(
          borderRadius: Corners.hgBorder,
          side: thinBorder(context, borderColor));

  static BorderSide thinBorder(BuildContext context, Color borderColor) =>
      BorderSide(width: Strokes.thin, color: borderColor);
}
