import 'package:ToDo/res/dimens/corners.dart';
import 'package:ToDo/res/dimens/insets.dart';
import 'package:ToDo/res/dimens/strokes.dart';
import 'package:ToDo/res/drawable/item_splitter.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class ButtonFiledItem extends StatefulWidget {
  Widget child;

  Widget? icon;
  EdgeInsetsGeometry? margin;
  Color? iconColor;
  Color? borderColor;
  Color? fillColor;
  Color? rippleColor;

  bool isFiled = false;

  Alignment? alignment;

  Function()? onTap;

  ButtonFiledItem(
      {super.key,
      required this.child,
      this.icon,
      this.iconColor,
      this.borderColor,
      this.fillColor,
      this.margin,
      this.alignment,
      this.onTap,
      this.rippleColor}) {
    borderColor = borderColor ?? getSelectedThemeColors().borderColor;
    fillColor = fillColor ??
        (isDark()
            ? getSelectedThemeColors().onBackground
            : getSelectedThemeColors().itemFillColor);
    rippleColor = rippleColor ?? borderColor!.withAlpha(80);
    iconColor = iconColor ?? borderColor;
  }

  @override
  State<StatefulWidget> createState() {
    return _ButtonFiledItemState();
  }
}

class _ButtonFiledItemState extends State<ButtonFiledItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => widget.onTap?.call(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.fillColor!),
          overlayColor: MaterialStateProperty.all<Color>(widget.rippleColor!),
          elevation: MaterialStateProperty.all<double>(2),
          minimumSize: MaterialStateProperty.all<Size>(
              Size(double.infinity, Insets.buttonHeight)),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: Corners.hgBorder,
            side: BorderSide(width: Strokes.thin, color: widget.borderColor!),
          )),
        ),
        child: widget.icon != null
            ? Row(
                children: [
                  ItemSplitter.ultraThinSplitter,
                  widget.icon!,
                  ItemSplitter.ultraThinSplitter,
                  Expanded(
                    child: widget.child,
                  )
                ],
              )
            : widget.child);
  }
}
