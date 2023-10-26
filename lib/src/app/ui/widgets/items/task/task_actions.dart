import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/res/texts.dart';
import 'package:kardone/src/app/ui/pages/task/create/create_task_item_page.dart';
import 'package:kardone/src/domain/models/category/category_item.dart';
import 'package:kardone/src/domain/models/task/task_item.dart';
import 'package:kardone/src/utils/direction_util.dart';
import 'package:kardone/src/utils/extentions/translates_string_extentions.dart';
import 'package:kardone/src/utils/navigator.dart';
import 'package:kardone/src/utils/theme_utils.dart';

import '../../bottomsheet/round_bottom_sheet.dart';
import '../../buttons/custom_flat_button.dart';
import '../../buttons/task_action_button.dart';
import '../../image/image_view.dart';

class TaskActions extends StatelessWidget {
  TaskItem taskItem;
  Function()? onDone;
  Function()? onDelete;
  Function()? onEdit;
  Function()? onChangeDate;

  TaskActions(
      {super.key,
      required this.taskItem,
      this.onDone,
      this.onChangeDate,
      this.onDelete,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Insets.xs),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _taskActionDone(),
          _taskActionChangeDate(context),
          _taskActionEdit(context),
          _taskActionDelete(context),
        ],
      ),
    );
  }

  Widget _taskActionDone() {
    return TaskActionButton(
      title: Texts.taskDetailButtonDone.translate,
      icon: AppIcons.doneChecked,
      color: taskItem.isDone
          ? getSelectedThemeColors().disableColor
          : getSelectedThemeColors().iconGreen,
      onTap: () {
        taskItem.isDone = !taskItem.isDone;
        onDone?.call();
      },
    );
  }

  Widget _taskActionChangeDate(BuildContext context) {
    return TaskActionButton(
      title: Texts.taskDetailButtonChangeDate.translate,
      icon: AppIcons.changeDate,
      onTap: () {
        showDatePickerDialog(context, initialTime: taskItem.taskTimestamp,
            onDateSelected: (timestamp) {
          taskItem.taskTimestamp = timestamp;
          onChangeDate?.call();
        });
      },
      color: getSelectedThemeColors().accentColor,
    );
  }

  Widget _taskActionEdit(BuildContext context) {
    return TaskActionButton(
      title: Texts.taskDetailButtonEdit.translate,
      icon: AppIcons.edit,
      color: getSelectedThemeColors().iconBlue,
      onTap: () {
        navigateToPage(
            context,
            CreateTaskItemPage(
              taskItem: taskItem,
            )).then((value) => onEdit?.call());
      },
    );
  }

  Widget _taskActionDelete(BuildContext context) {
    return TaskActionButton(
      title: Texts.taskDetailButtonDelete.translate,
      icon: AppIcons.delete,
      color: getSelectedThemeColors().iconRed,
      onTap: () {
        showDeleteDialog(context, onDeleted: () {
          onDelete?.call();
        }, text: Texts.taskDetailPageCategory);
      },
    );
  }
}
