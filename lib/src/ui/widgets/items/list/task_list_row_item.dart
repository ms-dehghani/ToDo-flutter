import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/ui/widgets/check_box/check_box_item.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/utils/theme_utils.dart';
import 'package:kardone/src/utils/time_util.dart';

import '../../round_colored_container.dart';

class TaskListRowItem extends StatefulWidget {
  TaskItem taskItem;
  Function()? onTap;
  Function(bool)? onDone;

  TaskListRowItem({super.key, required this.taskItem, this.onTap, this.onDone});

  @override
  State<TaskListRowItem> createState() => _TaskListRowItemState();
}

class _TaskListRowItemState extends State<TaskListRowItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: Insets.sm),
        elevation: widget.taskItem.isDone ? 0 : Insets.xs,
        color: getSelectedThemeColors().itemFillColor,
        shadowColor: getSelectedThemeColors().shadowColor,
        shape: Borders.thinAndHighRadiosBorder,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            ItemSplitter.medSplitter,
            _rowTitle(),
            _rowDetail(),
            _rowReminder(),
          ],
        ),
      ),
    );
  }

  Widget _rowTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 6,
          height: 24,
          decoration: BoxDecoration(
              borderRadius: Corners.smBorder,
              color: widget.taskItem.isDone
                  ? getSelectedThemeColors().disableColor
                  : widget.taskItem.priorityItem?.color ?? getSelectedThemeColors().disableColor),
        ),
        ItemSplitter.ultraThinSplitter,
        getScaledCheckBox(widget.taskItem.isDone, (value) {
          widget.taskItem.isDone = value!;
          widget.onDone?.call(widget.taskItem.isDone);
        }),
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
            child: ImageView(
              src: AppIcons.dotsHorizontal,
              color: getSelectedThemeColors().secondaryText,
              size: Insets.iconSizeXL,
            ),
        ),
      ],
    );
  }

  Widget _rowDetail() {
    if (widget.taskItem.categoryItem == null) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.med),
      child: Column(
        children: [
          ItemSplitter.ultraThinSplitter,
          Row(
            children: [
              ItemSplitter.ultraThinSplitter,
              RoundColoredContainer(
                color: !widget.taskItem.isDone
                    ? getSelectedThemeColors().iconBlue.withOpacity(0.1)
                    : getSelectedThemeColors().disableColor.withOpacity(0.1),
                child: Row(
                  children: [
                    ImageView(
                      src: AppIcons.category,
                      color: getSelectedThemeColors().iconBlue,
                      size: Insets.iconSizeS,
                    ),
                    ItemSplitter.ultraThinSplitter,
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
      ),
    );
  }

  Widget _rowReminder() {
    return Padding(
      padding: EdgeInsets.only(left: Insets.med, top: 0, bottom: Insets.med, right: Insets.med),
      child: RoundColoredContainer(
        height: 34,
        margin: EdgeInsets.symmetric(horizontal: Insets.xs),
        color: !widget.taskItem.isDone
            ? getSelectedThemeColors().disableColor.withOpacity(0.1)
            : getSelectedThemeColors().disableColor.withOpacity(0.1),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ImageView(
              src: AppIcons.calendar,
              color: getSelectedThemeColors().secondaryText,
              size: Insets.iconSizeM,
            ),
            ItemSplitter.ultraThinSplitter,
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
      ),
    );
  }
}
