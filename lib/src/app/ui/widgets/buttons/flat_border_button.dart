import 'package:ToDo/res/dimens/borders.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class FlatBorderButton extends StatelessWidget {
  Size? size;
  Color? borderColor;
  Color? backColor;
  Color? rippleColor;

  Function()? onTap;

  Widget child;

  FlatBorderButton(
      {super.key,
      required this.child,
      this.size,
      this.borderColor,
      this.backColor,
      this.rippleColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap?.call(),
      style: TextButton.styleFrom(
          fixedSize: size,
          backgroundColor: backColor ?? Colors.transparent,
          foregroundColor: rippleColor,
          shape: Borders.thinAndHighRadiosBorder(
                  context, getSelectedThemeColors().borderColor)
              .copyWith(
                  side: Borders.thinAndHighRadiosBorder(
                          context, getSelectedThemeColors().borderColor)
                      .side
                      .copyWith(color: borderColor ?? Colors.transparent))),
      child: child,
    );
  }
}
