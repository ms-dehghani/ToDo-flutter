import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';

class CustomButton extends StatelessWidget {
  Size? size;
  Color? fillColor;
  Color? rippleColor;

  Function()? onTap;

  Widget child;

  CustomButton(
      {super.key, required this.child, this.size, this.fillColor, this.rippleColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap?.call(),
      style: ElevatedButton.styleFrom(
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
