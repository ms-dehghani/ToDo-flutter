import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ToDo/res/color.dart';
import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/app/ui/widgets/check_box/check_box_item.dart';
import 'package:ToDo/src/utils/device.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:ToDo/src/utils/time_util.dart';

import '../../bottomsheet/round_bottom_sheet.dart';
import '../../image/image_view.dart';
import '../../round_colored_container.dart';
import '../task/task_actions.dart';

class TaskListRowItem extends StatefulWidget {
  TaskItem taskItem;
  Function() onTap;
  Function(bool) onDone;
  Function() onDelete;
  Function() onEdit;
  Function() onChangeDate;

  TaskListRowItem(
      {super.key,
      required this.taskItem,
      required this.onTap,
      required this.onDone,
      required this.onEdit,
      required this.onChangeDate,
      required this.onDelete});

  @override
  State<TaskListRowItem> createState() => _TaskListRowItemState();
}

class _TaskListRowItemState extends State<TaskListRowItem> {
  @override
  Widget build(BuildContext context) {
    return _cardView(true);
  }

  Widget _cardView(bool clickable) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: Insets.sm),
      elevation: widget.taskItem.isDone || !clickable ? 0 : Insets.xs,
      color: getSelectedThemeColors().itemFillColor,
      shadowColor: getSelectedThemeColors().shadowColor,
      shape: Borders.thinAndHighRadiosBorder,
      child: InkWell(
        borderRadius: Corners.hgBorder,
        splashColor: getSelectedThemeColors().disableColor.withOpacity(0.3),
        highlightColor: Colors.transparent,
        onTap: () {
          widget.onTap.call();
        },
        onLongPress:() {
          _showMenuDialog();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            ItemSplitter.medSplitter,
            _rowTitle(clickable),
            _rowDetail(),
            _rowReminder(),
          ],
        ),
      ),
    );
  }

  Widget _rowTitle(bool clickable) {
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
        _checkBox(clickable),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top:Insets.xs ,bottom: Insets.xs),
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
        Visibility(
          visible: clickable,
          child: GestureDetector(
            onTap: () => _showMenuDialog(),
            child: Container(
              width: Insets.buttonHeight,
              height: Insets.backButtonHeight,
              padding: EdgeInsets.all(Insets.sm),
              margin: EdgeInsets.symmetric(horizontal: Insets.sm),
              child: ImageView(
                src: AppIcons.dotsHorizontal,
                color: getSelectedThemeColors().secondaryText,
                size: Insets.iconSizeXL,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _checkBox(bool clickable) {
    return getScaledCheckBox(
        widget.taskItem.isDone,
        clickable
            ? (value) {
                if (widget.taskItem.isDone) {
                  widget.taskItem.isDone = value!;
                  widget.onDone.call(widget.taskItem.isDone);
                } else {
                  showDoneTaskDialog(
                    context,
                    onDone: () {
                      widget.taskItem.isDone = value!;
                      widget.onDone.call(widget.taskItem.isDone);
                    },
                  );
                }
              }
            : null);
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

  void _showMenuDialog() {
    showGeneralDialog(
      context: context,
      barrierColor: UiColors.bottomSheetBackDropBackground,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (_, __, ___) {
        if (widget.key == null) {
          return Container();
        }
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: _taskWithActions(),
        );
      },
    );
  }

  Widget _taskWithActions() {
    Widget actions = Container(
      width: double.infinity,
      height: Insets.taskActionBarHeight,
      decoration: Drawable.simpleBorder(getSelectedThemeColors()),
      child: TaskActions(
          taskItem: widget.taskItem,
          onDone: () {
            Navigator.of(context).maybePop();
            widget.onDone.call(widget.taskItem.isDone);
          },
          onChangeDate: () {
            Navigator.of(context).maybePop();
            widget.onChangeDate.call();
          },
          onDelete: () {
            Navigator.of(context).maybePop();
            widget.onDelete.call();
          },
          onEdit: () {
            Navigator.of(context).maybePop();
            widget.onEdit.call();
          }),
    );

    if (widget.key == null) {
      return Container();
    }

    var key = (widget.key as GlobalKey).currentContext;
    RenderBox box = key!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);

    var height = getHeight(context);
    bool actionIsFirst =
        box.size.height + Insets.taskActionBarHeight + Insets.med + position.dy > height;

    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          child: SizedBox(
            width: box.size.width,
            height: box.size.height + Insets.taskActionBarHeight + Insets.med,
            child: Column(
              children: [
                actionIsFirst ? actions : _cardView(false),
                ItemSplitter.ultraThinSplitter,
                actionIsFirst ? _cardView(false) : actions,
              ],
            ),
          ),
        )
      ],
    );
  }
}
