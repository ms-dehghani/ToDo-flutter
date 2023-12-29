import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/utils/direction_util.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../buttons/custom_flat_button.dart';
import '../../image/image_view.dart';

class CategoryListRowItem extends StatefulWidget {
  CategoryItem categoryItem;
  Function()? onTap;
  Function()? onEditTap;

  CategoryListRowItem({super.key, required this.categoryItem, this.onTap, this.onEditTap});

  @override
  State<CategoryListRowItem> createState() => _TaskListRowItemState();
}

class _TaskListRowItemState extends State<CategoryListRowItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Insets.xs),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CustomFlatButton(
              elevation: 0,
              size: Size(double.infinity, Insets.buttonHeight),
              fillColor: getSelectedThemeColors(context).pageBackground,
              child: Align(
                alignment: isRTL() ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  widget.categoryItem.title,
                  style: TextStyles.h2.copyWith(color: getSelectedThemeColors(context).primaryText),
                ),
              ),
              onTap: () {
                widget.onTap?.call();
              },
            ),
          ),
          ItemSplitter.ultraThinSplitter,
          Visibility(
            visible: widget.categoryItem.ID != "0",
            child: CustomFlatButton(
              elevation: 0,
              size: Size(Insets.buttonHeight, Insets.buttonHeight),
              fillColor: getSelectedThemeColors(context).iconBlue.withOpacity(0.05),
              rippleColor: getSelectedThemeColors(context).iconBlue.withOpacity(0.5),
              child: Align(
                alignment: Alignment.center,
                child: ImageView(
                  src: AppIcons.edit,
                  size: Insets.iconSizeXL,
                  color: getSelectedThemeColors(context).iconBlue,
                ),
              ),
              onTap: () {
                widget.onEditTap?.call();
              },
            ),
          ),
          ItemSplitter.ultraThinSplitter,
        ],
      ),
    );
  }
}
