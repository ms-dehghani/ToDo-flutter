import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/utils/extentions/translates_string_extentions.dart';
import 'package:kardone/src/utils/theme_utils.dart';

import '../../buttons/custom_flat_button.dart';

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
              fillColor: getSelectedThemeColors().pageBackground,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.categoryItem.ID == "0"
                      ? widget.categoryItem.title.translate
                      : widget.categoryItem.title,
                  style: TextStyles.h2.copyWith(color: getSelectedThemeColors().primaryText),
                ),
              ),
              onTap: () {
                widget.onTap?.call();
              },
            ),
          ),
          ItemSplitter.thinSplitter,
          Visibility(
            visible: widget.categoryItem.ID != "0",
            child: CustomFlatButton(
              elevation: 0,
              size: Size(Insets.buttonHeight, Insets.buttonHeight),
              fillColor: getSelectedThemeColors().iconBlue.withOpacity(0.05),
              rippleColor: getSelectedThemeColors().iconBlue.withOpacity(0.5),
              child: Align(
                alignment: Alignment.center,
                child: ImageView(
                  src: AppIcons.edit,
                  size: Insets.iconSizeXL,
                  color: getSelectedThemeColors().iconBlue,
                ),
              ),
              onTap: () {
                widget.onEditTap?.call();
              },
            ),
          ),
          ItemSplitter.thinSplitter,
        ],
      ),
    );
  }
}
