import 'package:flutter/material.dart';
import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/src/utils/theme_utils.dart';

Widget getCheckBox(bool value, ValueChanged<bool?>? onChanged) {
  return Checkbox(
    value: value,
    onChanged: onChanged,
    shape: const RoundedRectangleBorder(borderRadius: Corners.medBorder),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return getSelectedThemeColors().primaryColor;
      } else {
        return getSelectedThemeColors().itemFillColor;
      }
    }),
    side: Borders.thinBorder,
  );
}

Widget getScaledCheckBox(bool value, ValueChanged<bool?>? onChanged) {
  return Transform.scale(
    scale: 1.2,
    child: getCheckBox(value, onChanged),
  );
}
