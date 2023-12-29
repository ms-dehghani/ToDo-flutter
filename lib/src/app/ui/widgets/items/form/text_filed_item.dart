import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

import '../../image/image_view.dart';

class TextFiledItem extends StatefulWidget {
  String text;
  String hint;
  Border? border;
  TextStyle? textStyle;
  TextStyle? hintTextStyle;
  int maxLines, minLines;

  String? icon;
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
      this.icon = "",
      this.iconColor = Colors.white,
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

    widget.textStyle ??= TextStyles.h3.copyWith(color: getSelectedThemeColors(context).primaryText);
    widget.hintTextStyle ??=
        TextStyles.h3.copyWith(color: getSelectedThemeColors(context).secondaryText);

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
      decoration: Drawable.simpleBorder(getSelectedThemeColors(context)),
      padding: EdgeInsets.symmetric(horizontal: Insets.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.icon!.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.sm),
                  child: ImageView(
                    src: widget.icon!,
                    color: _controler.text.isEmpty
                        ? getSelectedThemeColors(context).disableColor
                        : widget.iconColor,
                    size: Insets.iconSizeS,
                  ),
                )
              : SizedBox(),
          Expanded(
            child: TextField(
              controller: _controler,
              onChanged: (value) {
                widget.onValueChange?.call(value);
                if (value.length < 2) {
                  setState(() {});
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: widget.hintTextStyle,
                hintMaxLines: 1,
              ),
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              style: widget.textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
