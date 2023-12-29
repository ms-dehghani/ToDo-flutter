import 'package:ToDo/res/dimens.dart';
import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  Size? size;
  Color? borderColor;
  Color? backColor;
  Color? rippleColor;

  Function()? onTap;

  Widget child;

  BorderButton(
      {super.key,
      required this.child,
      this.size,
      this.borderColor,
      this.backColor,
      this.rippleColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap?.call(),
      style: ElevatedButton.styleFrom(
          fixedSize: size,
          backgroundColor: backColor ?? Colors.transparent,
          foregroundColor: rippleColor,
          shape: Borders.thinAndHighRadiosBorder(context).copyWith(
              side: Borders.thinAndHighRadiosBorder(context)
                  .side
                  .copyWith(color: borderColor ?? Colors.transparent))),
      child: child,
    );
  }
}
