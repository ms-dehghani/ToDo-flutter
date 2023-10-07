import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/theme/theme_color.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class TextFiledItem extends StatefulWidget {
  String text;
  String hint;
  Border? border;
  TextStyle? textStyle;
  TextStyle? hintTextStyle;
  int maxLines, minLines;

  Widget? icon;
  Color? iconColor;

  Function(String newValue)? onValueChange;

  TextFiledItem(
      {super.key,
      required this.text,
      required this.hint,
      this.border,
      this.maxLines = 1,
      this.minLines = 1,
      this.textStyle,
      this.icon,
      this.iconColor,
      this.hintTextStyle,
      this.onValueChange});

  @override
  State<StatefulWidget> createState() {
    return _TextFiledItemState();
  }
}

class _TextFiledItemState extends State<TextFiledItem> {
  late TextEditingController _controler;

  @override
  void initState() {
    super.initState();
    _controler = TextEditingController();
    _controler.text = widget.text;
  }

  @override
  void dispose() {
    _controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Drawable.simpleBorder(getSelectedThemeColors()),
      padding: EdgeInsets.symmetric(horizontal: Insets.sm),
      child: TextField(
        controller: _controler,
        onChanged: (value) {
          widget.onValueChange?.call(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: widget.hintTextStyle,
          hintMaxLines: 1,
          prefix: widget.icon,
        ),
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        style: widget.textStyle,
      ),
    );
  }
}
