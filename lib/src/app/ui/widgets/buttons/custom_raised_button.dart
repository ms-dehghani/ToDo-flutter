import 'package:ToDo/res/dimens.dart';
import 'package:flutter/material.dart';

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
          shape: Borders.thinAndHighRadiosBorder(context).copyWith(
              side: Borders.thinAndHighRadiosBorder(context)
                  .side
                  .copyWith(color: fillColor ?? Colors.transparent))),
      child: child,
    );
  }
}
