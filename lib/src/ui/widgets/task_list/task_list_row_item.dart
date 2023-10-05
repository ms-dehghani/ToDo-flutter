import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/ui/widgets/check_box/check_box_item.dart';
import 'package:kardone/src/utils/theme_utils.dart';
import 'package:kardone/src/utils/time_util.dart';

import '../round_colored_container.dart';

class TaskListRowItem extends StatefulWidget {
  TaskItem taskItem;
  Function()? onTap;

  TaskListRowItem({super.key, required this.taskItem, this.onTap});

  @override
  State<TaskListRowItem> createState() => _TaskListRowItemState();
}

class _TaskListRowItemState extends State<TaskListRowItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: Insets.sm),
      elevation: widget.taskItem.isDone ? 0 : Insets.xs,
      color: getSelectedThemeColors().itemFillColor,
      shadowColor: getSelectedThemeColors().shadowColor,
      shape: Borders.thinAndHighRadiosBorder,
      child: Stack(
        children: [
          Container(
            width: 6,
            height: 24,
            margin: EdgeInsets.only(top: Insets.med),
            decoration: BoxDecoration(
                borderRadius: Corners.smBorder,
                color: widget.taskItem.isDone
                    ? getSelectedThemeColors().disableColor
                    : widget.taskItem.priorityItem?.color ?? getSelectedThemeColors().disableColor),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(Insets.med, Insets.sm, Insets.med, Insets.med),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _rowTitle(),
                _rowDetail(),
                _rowReminder(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getScaledCheckBox(widget.taskItem.isDone, (value) {
          setState(() {
            widget.taskItem.isDone = value!;
          });
        }),
        ItemSplitter.thinSplitter,
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(Insets.xs),
            child: Text(
              widget.taskItem.title,
              maxLines: 2,
              style: TextStyles.h2.copyWith(
                  decoration:
                      widget.taskItem.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  color: widget.taskItem.isDone
                      ? getSelectedThemeColors().disableColor
                      : getSelectedThemeColors().primaryText),
            ),
          ),
        ),
        Container(
          width: 48,
          margin: EdgeInsets.symmetric(horizontal: Insets.sm),
        ),
      ],
    );
  }

  Widget _rowDetail() {
    if (widget.taskItem.categoryItem == null) {
      return Container();
    }
    return Column(
      children: [
        ItemSplitter.thinSplitter,
        Row(
          children: [
            ItemSplitter.thinSplitter,
            RoundColoredContainer(
              color: !widget.taskItem.isDone
                  ? getSelectedThemeColors().iconBlue.withOpacity(0.1)
                  : getSelectedThemeColors().disableColor.withOpacity(0.1),
              child: Row(
                children: [
                  Container(),
                  ItemSplitter.thinSplitter,
                  Text(
                    widget.taskItem.categoryItem?.title ?? "",
                    style: TextStyles.h3.copyWith(
                        color: !widget.taskItem.isDone
                            ? getSelectedThemeColors().iconBlue
                            : getSelectedThemeColors().disableColor),
                  )
                ],
              ),
            )
          ],
        ),
        ItemSplitter.medSplitter,
      ],
    );
  }

  Widget _rowReminder() {
    return RoundColoredContainer(
      height: 34,
      margin: EdgeInsets.symmetric(horizontal: Insets.xs),
      color: !widget.taskItem.isDone
          ? getSelectedThemeColors().disableColor.withOpacity(0.1)
          : getSelectedThemeColors().disableColor.withOpacity(0.1),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(),
          ItemSplitter.thinSplitter,
          Flexible(
            child: Text(
              timeToText(widget.taskItem.taskTimestamp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.h3.copyWith(
                  color: !widget.taskItem.isDone
                      ? getSelectedThemeColors().secondaryText
                      : getSelectedThemeColors().disableColor),
            ),
          )
        ],
      ),
    );
  }
}
