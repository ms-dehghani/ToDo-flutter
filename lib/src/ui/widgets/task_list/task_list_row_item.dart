import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class TaskListRowItem extends StatelessWidget {
  TaskItem taskItem;
  Function()? onTap;

  TaskListRowItem({super.key, required this.taskItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Card(
        elevation: Insets.xs,
        color: getSelectedThemeColors().itemFillColor,
        shadowColor: getSelectedThemeColors().shadowColor,
        shape: const RoundedRectangleBorder(
          borderRadius: Corners.medBorder,
        ),
        child: Text(taskItem.title),
      ),
    );
  }
}
