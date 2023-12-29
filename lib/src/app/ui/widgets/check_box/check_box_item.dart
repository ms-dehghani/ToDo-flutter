import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

Widget getCheckBox(BuildContext context, bool value, ValueChanged<bool?>? onChanged) {
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
    side: Borders.thinBorder(context).copyWith(
        color: isDark()
            ? getSelectedThemeColors().primaryText
            : getSelectedThemeColors().disableColor),
  );
}

Widget getScaledCheckBox(BuildContext context, bool value, ValueChanged<bool?>? onChanged) {
  return Transform.scale(
    scale: 1.2,
    child: getCheckBox(context, value, onChanged),
  );
}
