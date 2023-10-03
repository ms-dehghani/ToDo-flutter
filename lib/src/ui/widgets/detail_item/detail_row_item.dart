import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class AnimatedContainerItem extends StatelessWidget {
  String title;
  Widget child;
  Color? titleColor;
  BoxDecoration? decoration;

  Function()? onTap;

  AnimatedContainerItem(
      {super.key,
      required this.title,
      required this.child,
      this.titleColor,
      this.decoration,
      this.onTap}) {
    decoration = decoration ?? Drawable.itemDetailDecoration(getSelectedThemeColors());
    titleColor = titleColor ?? getSelectedThemeColors().primaryText;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        padding: EdgeInsets.all(Insets.med),
        decoration: decoration,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyles.h3Bold.copyWith(color: titleColor),
                ),
              ],
            ),
            ItemSplitter.thinSplitter,
            child
          ],
        ),
      ),
    );
  }
}
