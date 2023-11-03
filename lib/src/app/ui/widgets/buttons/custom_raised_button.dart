import 'package:flutter/material.dart';
import 'package:ToDo/res/dimens.dart';

class CustomRaisedButton extends StatelessWidget {
  Size? size;
  Color? fillColor;
  Color? rippleColor;

  Function()? onTap;
  double elevation;

  Widget child;

  CustomRaisedButton(
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
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          fixedSize: size,
          backgroundColor: fillColor,
          foregroundColor: rippleColor,
          shape: Borders.thinAndHighRadiosBorder.copyWith(
              side: Borders.thinAndHighRadiosBorder.side
                  .copyWith(color: fillColor ?? Colors.transparent))),
      child: child,
    );
  }
}
