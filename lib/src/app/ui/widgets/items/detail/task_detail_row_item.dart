import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
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
    decoration = decoration ?? Drawable.itemDetailDecoration(getSelectedThemeColors(context));
    titleColor = titleColor ?? getSelectedThemeColors(context).primaryText;
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
                ItemSplitter.ultraThinSplitter,
                ItemSplitter.ultraThinSplitter,
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
