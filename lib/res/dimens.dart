import 'package:flutter/material.dart';
import 'package:kardone/res/color.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class Insets {
  static double scale = 1;
  static double offsetScale = 1;

  // Regular paddings
  static double get xs => 4 * scale;

  static double get sm => 8 * scale;

  static double get med => 12 * scale;

  static double get lg => 16 * scale;

  static double get xl => 32 * scale;

  static double get buttonHeight => 48 * scale;

  static double get taskRowItemMinHeight => 100 * scale;

  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

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
  static const Radius hgRadius = Radius.circular(hg);

}

class Borders {
  static RoundedRectangleBorder thinAndMedRadiosBorder =
      RoundedRectangleBorder(borderRadius: Corners.medBorder, side: thinBorder);

  static RoundedRectangleBorder thinAndHighRadiosBorder =
  RoundedRectangleBorder(borderRadius: Corners.hgBorder, side: thinBorder);

  static BorderSide thinBorder =
      BorderSide(width: Strokes.thin, color: getSelectedThemeColors().borderColor);
}

class ItemSplitter {
  static Widget thinSplitter = SizedBox(
    width: Insets.xs,
    height: Insets.xs,
  );
  static Widget thickSplitter = SizedBox(
    width: Insets.lg,
    height: Insets.lg,
  );

  static Widget medSplitter = SizedBox(
    width: Insets.med,
    height: Insets.med,
  );

  static Widget splitter(double value) => SizedBox(
        width: value,
        height: value,
      );
}

class Strokes {
  static const double thin = 1;
  static const double thick = 4;
}

class FontSizes {
  static double get scale => 1;

  static double get s10 => 10 * scale;

  static double get s11 => 11 * scale;

  static double get s12 => 12 * scale;

  static double get s14 => 14 * scale;

  static double get s16 => 16 * scale;

  static double get s18 => 18 * scale;

  static double get s20 => 20 * scale;

  static double get s24 => 24 * scale;

  static double get s48 => 48 * scale;
}
