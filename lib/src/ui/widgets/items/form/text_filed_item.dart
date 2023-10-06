import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/theme/theme_color.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class TextFiledItem extends StatefulWidget {
  String text;
  String hint;
  Border? border;
  TextStyle? textStyle;
  TextStyle? hintTextStyle;
  int maxLines;

  Widget? icon;
  Color? iconColor;

  Function(String newValue)? onValueChange;

  TextFiledItem(
      {super.key,
      required this.text,
      required this.hint,
      this.border,
      this.maxLines = 1,
      this.textStyle,
      this.hintTextStyle,
      this.onValueChange});

  @override
  State<StatefulWidget> createState() {
    return _TextFiledItemState();
  }
}

class _TextFiledItemState extends State<TextFiledItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Drawable.simpleBorder(getSelectedThemeColors()),
      child: TextField(
        onChanged: (value) => widget.onValueChange?.call(value),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: widget.hintTextStyle,
            hintMaxLines: 1,
            prefixIcon: widget.icon,
            prefixIconColor: widget.iconColor),
        maxLines: widget.maxLines,
        style: widget.textStyle,
      ),
    );
  }
}
