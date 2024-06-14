import 'package:ToDo/res/dimens/insets.dart';
import 'package:ToDo/res/drawable/app_icons.dart';
import 'package:ToDo/res/drawable/item_splitter.dart';
import 'package:ToDo/res/string/texts.dart';
import 'package:ToDo/res/styles/text_style.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../image/image_view.dart';
import 'priority_button_widget.dart';

class PrioritySelectorFiledItem extends StatefulWidget {
  List<PriorityItem> priorityList;
  PriorityItem? selectedItem;

  Function(PriorityItem item)? onPriorityChange;

  PrioritySelectorFiledItem(
      {super.key,
      required this.priorityList,
      this.selectedItem,
      this.onPriorityChange});

  @override
  State<StatefulWidget> createState() {
    return _PrioritySelectorFiledItemState();
  }
}

class _PrioritySelectorFiledItemState extends State<PrioritySelectorFiledItem> {
  List<PriorityButtonWidget> priorityListWidgets = [];

  void initList() {
    if (priorityListWidgets.isEmpty) {
      priorityListWidgets = widget.priorityList.map((e) {
        return PriorityButtonWidget(
          priorityItem: e,
          isSelected: e.ID == widget.selectedItem?.ID,
          onSelect: () {
            for (var element in priorityListWidgets) {
              if (e.ID != element.priorityItem.ID) {
                element.onDeselect();
              }
            }
            widget.onPriorityChange?.call(e);
          },
        );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    initList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        ImageView(
          src: AppIcons.priorityOutline,
          size: Insets.iconSizeS,
          color: getSelectedThemeColors().secondaryText,
        ),
        ItemSplitter.ultraThinSplitter,
        Text(
          Texts.addTaskRowPrioritySelect.translate,
          style: TextStyles.h3
              .copyWith(color: getSelectedThemeColors().secondaryText),
        ),
        ItemSplitter.ultraThinSplitter,
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: priorityListWidgets,
          ),
        )
      ],
    );
  }
}
