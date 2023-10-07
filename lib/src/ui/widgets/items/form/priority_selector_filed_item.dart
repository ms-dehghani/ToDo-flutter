import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/res/texts.dart';
import 'package:kardone/src/model/items/tasks/priority/pojo/priority_item.dart';
import 'package:kardone/src/utils/theme_utils.dart';

import 'priority_button_widget.dart';

class PrioritySelectorFiledItem extends StatefulWidget {
  List<PriorityItem> priorityList;
  PriorityItem? selectedItem;

  Function(PriorityItem item)? onPriorityChange;

  PrioritySelectorFiledItem(
      {super.key, required this.priorityList, this.selectedItem, this.onPriorityChange});

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
        Text(
          Texts.selectPriority,
          style: TextStyles.h3.copyWith(color: getSelectedThemeColors().secondaryText),
        ),
        ItemSplitter.thinSplitter,
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