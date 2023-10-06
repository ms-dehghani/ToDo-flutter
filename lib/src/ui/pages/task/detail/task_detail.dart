import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/ui/widgets/app_bar.dart';
import 'package:kardone/src/ui/widgets/base/widget_view_template.dart';
import 'package:kardone/src/ui/widgets/buttons/back_button.dart';
import 'package:kardone/src/ui/widgets/buttons/task_action_button.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/ui/widgets/items/detail/task_detail_row_item.dart';
import 'package:kardone/src/utils/theme_utils.dart';
import 'package:animations/animations.dart';
import 'package:kardone/src/utils/time_util.dart';

class TaskDetailPage extends StatefulWidget {
  TaskItem taskItem;

  TaskDetailPage({required this.taskItem});

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailPageState();
  }
}

class _TaskDetailPageState extends State<TaskDetailPage> with WidgetViewTemplate {
  @override
  Widget build(BuildContext context) {
    return phoneView();
  }

  @override
  Widget phoneView() {
    return Container(
      color: getSelectedThemeColors().pageBackground,
      child: SafeArea(
        child: Column(
          children: [
            ApplicationAppBar(
                leftWidget: AppBarBackButton(
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                centerWidget: Text(
                  "detail page",
                  style: TextStyles.h2Bold.copyWith(color: getSelectedThemeColors().primaryColor),
                )),
            Expanded(child: _taskDetail()),
            _taskActions()
          ],
        ),
      ),
    );
  }

  Widget _taskDetail() {
    return ListView(
      children: [
        ItemSplitter.thickSplitter,
        _taskTitle(),
        ItemSplitter.thickSplitter,
        TaskDetailRowItem(
          title: "detail",
          titleColor: getSelectedThemeColors().iconPurple,
          child: Text(
            widget.taskItem.description,
            style: TextStyles.h2.copyWith(color: getSelectedThemeColors().secondaryText),
          ),
        ),
      ],
    );
  }

  Widget _taskTitle() {
    return Container(
      padding: EdgeInsets.all(Insets.med),
      decoration: Drawable.itemDetailDecoration(getSelectedThemeColors()),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.taskItem.title,
            style: TextStyles.h1Bold.copyWith(color: getSelectedThemeColors().primaryText),
          ),
          ItemSplitter.thickSplitter,
          _taskDetailRow2(),
          ItemSplitter.thickSplitter,
          _dotedDetail()
        ],
      ),
    );
  }

  Widget _taskDetailRow2() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _taskPriority(),
        ItemSplitter.thickSplitter,
        Container(
          width: Strokes.thin,
          height: Insets.lg,
          color: getSelectedThemeColors().borderColor,
        ),
        ItemSplitter.thickSplitter,
        _taskCategory()
      ],
    );
  }

  Widget _taskPriority() {
    return Row(
      children: [
        ImageView(
          src: "src",
          size: Insets.iconSizeS,
          color: widget.taskItem.priorityItem!.color,
        ),
        ItemSplitter.thinSplitter,
        Text(
          "priority",
          style: TextStyles.h3.copyWith(color: widget.taskItem.priorityItem!.color),
        ),
        ItemSplitter.thinSplitter,
        Text(
          widget.taskItem.priorityItem!.title,
          style: TextStyles.h3Bold.copyWith(color: widget.taskItem.priorityItem!.color),
        )
      ],
    );
  }

  Widget _taskCategory() {
    return Row(
      children: [
        ImageView(
          src: "src",
          size: Insets.iconSizeS,
          color: getSelectedThemeColors().iconBlue,
        ),
        ItemSplitter.thinSplitter,
        Text(
          "cat",
          style: TextStyles.h3.copyWith(color: getSelectedThemeColors().iconBlue),
        ),
        ItemSplitter.thinSplitter,
        Text(
          widget.taskItem.categoryItem!.title,
          style: TextStyles.h3Bold.copyWith(color: getSelectedThemeColors().iconBlue),
        )
      ],
    );
  }

  Widget _dotedDetail() {
    return DottedBorder(
      color: getSelectedThemeColors().iconGreen,
      strokeWidth: 1,
      dashPattern: const [5, 5],
      borderType: BorderType.RRect,
      radius: Corners.hgRadius,
      child: Container(
        height: Insets.appBarHeight,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: Drawable.dotedBorderDecoration(getSelectedThemeColors()),
        child: Row(
          children: [
            ImageView(src: "src", size: Insets.iconSizeM),
            ItemSplitter.thinSplitter,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("date",
                    style: TextStyles.h3.copyWith(
                      color: getSelectedThemeColors().iconGreen,
                    )),
                Text(
                  timeToText(widget.taskItem.taskTimestamp),
                  style: TextStyles.h3Bold.copyWith(
                    color: getSelectedThemeColors().iconGreen,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _taskActions() {
    return Container(
      width: double.infinity,
      height: Insets.taskActionBarHeight,
      margin: EdgeInsets.only(left: Insets.med, right: Insets.med, bottom: Insets.med),
      decoration: Drawable.taskActionsDecoration(getSelectedThemeColors()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TaskActionButton(
            title: "action",
            icon: "",
            color: getSelectedThemeColors().iconGreen,
          ),
          TaskActionButton(
            title: "action",
            icon: "",
            color: getSelectedThemeColors().accentColor,
          ),
          TaskActionButton(
            title: "action",
            icon: "",
            color: getSelectedThemeColors().iconBlue,
          ),
          TaskActionButton(
            title: "action",
            icon: "",
            color: getSelectedThemeColors().iconRed,
          ),
        ],
      ),
    );
  }
}
