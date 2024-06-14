import 'package:ToDo/res/dimens/borders.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  Size? size;
  Color? fillColor;
  Color? rippleColor;

  Function()? onTap;
  double elevation;

  Widget child;

  CustomFlatButton(
      {super.key,
      required this.child,
      this.size,
      this.fillColor,
      this.rippleColor,
      this.onTap,
      this.elevation = 4});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap?.call(),
      style: TextButton.styleFrom(
          elevation: elevation,
          fixedSize: size,
          backgroundColor: fillColor,
          foregroundColor: rippleColor,
          shape: Borders.thinAndHighRadiosBorder(
                  context, getSelectedThemeColors().borderColor)
              .copyWith(
                  side: Borders.thinAndHighRadiosBorder(
                          context, getSelectedThemeColors().borderColor)
                      .side
                      .copyWith(color: fillColor ?? Colors.transparent))),
      child: child,
    );
  }
}
