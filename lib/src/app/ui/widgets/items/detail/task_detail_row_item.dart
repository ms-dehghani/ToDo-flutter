import 'package:ToDo/res/dimens/insets.dart';
import 'package:ToDo/res/drawable/drawable.dart';
import 'package:ToDo/res/drawable/item_splitter.dart';
import 'package:ToDo/res/styles/text_style.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

import '../../image/image_view.dart';

class TaskDetailRowItem extends StatelessWidget {
  String title;
  String? icon;
  Widget child;
  Color? titleColor;
  BoxDecoration? decoration;

  Function()? onTap;

  TaskDetailRowItem(
      {super.key,
      required this.title,
      required this.child,
      this.icon,
      this.titleColor,
      this.decoration,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    decoration =
        decoration ?? Drawable.itemDetailDecoration(getSelectedThemeColors());
    titleColor = titleColor ?? getSelectedThemeColors().primaryText;
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        padding: EdgeInsets.all(Insets.pagePadding),
        decoration: decoration,
        child: Column(
          children: [
            Row(
              children: [
                ImageView(
                  src: icon ?? "",
                  color: titleColor ?? Colors.transparent,
                  size: Insets.iconSizeL,
                ),
                ItemSplitter.thinSplitter,
                Expanded(
                  child: Text(
                    title,
                    style: TextStyles.h3Bold.copyWith(color: titleColor),
                  ),
                ),
              ],
            ),
            ItemSplitter.medSplitter,
            SizedBox(width: double.infinity, child: child)
          ],
        ),
      ),
    );
  }
}
