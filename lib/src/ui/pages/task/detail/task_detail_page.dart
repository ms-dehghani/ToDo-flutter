import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/di/di.dart';
import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_bloc.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_event.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_page_data.dart';
import 'package:kardone/src/logic/task/delete/bloc/task_delete_bloc.dart';
import 'package:kardone/src/logic/task/delete/bloc/task_delete_event.dart';
import 'package:kardone/src/logic/task/delete/bloc/task_delete_page_data.dart';
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

class TaskDetailPage extends StatelessWidget with WidgetViewTemplate {
  TaskItem taskItem;

  TaskDetailPage({required this.taskItem});

  late TaskCreateOrUpdateBloc _taskCreateOrUpdateBloc;

  late TaskDeleteBloc _taskDeleteBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCreateOrUpdateBloc>(
            create: (BuildContext context) => _taskCreateOrUpdateBloc =
                TaskCreateOrUpdateBloc(taskRepository: DI.instance().getTaskRepository())),
        BlocProvider<TaskDeleteBloc>(
          create: (BuildContext context) =>
              _taskDeleteBloc = TaskDeleteBloc(taskRepository: DI.instance().getTaskRepository()),
        ),
      ],
      child: Container(color: getSelectedThemeColors().pageBackground, child: showPage(context)),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return Container(
      color: getSelectedThemeColors().pageBackground,
      child: SafeArea(
        child: Column(
          children: [
            ApplicationAppBar(
                leftWidget: AppBarBackButton(
                  onTap: () => Navigator.of(context).maybePop(taskItem),
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
          icon: AppIcons.descriptionFill,
          titleColor: getSelectedThemeColors().iconPurple,
          child: Text(
            taskItem.description,
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
            taskItem.title,
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
        (taskItem.categoryItem == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: Strokes.thin,
                    height: Insets.lg,
                    color: getSelectedThemeColors().borderColor,
                  ),
                  ItemSplitter.thickSplitter,
                  _taskCategory()
                ],
              ))
      ],
    );
  }

  Widget _taskPriority() {
    return Row(
      children: [
        ImageView(
          src: AppIcons.priorityFill,
          size: Insets.iconSizeM,
          color: taskItem.priorityItem?.color,
        ),
        ItemSplitter.thinSplitter,
        Text(
          "priority",
          style: TextStyles.h3.copyWith(color: taskItem.priorityItem?.color),
        ),
        ItemSplitter.thinSplitter,
        Text(
          taskItem.priorityItem?.title ?? "",
          style: TextStyles.h3Bold.copyWith(color: taskItem.priorityItem?.color),
        )
      ],
    );
  }

  Widget _taskCategory() {
    return Row(
      children: [
        ImageView(
          src: AppIcons.category,
          size: Insets.iconSizeM,
          color: getSelectedThemeColors().iconBlue,
        ),
        ItemSplitter.thinSplitter,
        Text(
          "cat",
          style: TextStyles.h3.copyWith(color: getSelectedThemeColors().iconBlue),
        ),
        ItemSplitter.thinSplitter,
        Text(
          taskItem.categoryItem?.title ?? "",
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
            ItemSplitter.medSplitter,
            ImageView(
                src: AppIcons.calendarFill,
                color: getSelectedThemeColors().iconGreen,
                size: Insets.iconSizeL),
            ItemSplitter.thinSplitter,
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
                  timeToText(taskItem.taskTimestamp),
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
    return MultiBlocListener(
      listeners: [
        BlocListener<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
          listener: (context, state) {},
        ),
        BlocListener<TaskDeleteBloc, TaskDeleteBlocPageData>(
          listener: (context, state) {
            if (state.pageStatus == PageStatus.success) {
              Navigator.of(context).maybePop(taskItem);
            }
          },
        ),
      ],
      child: Container(
        width: double.infinity,
        height: Insets.taskActionBarHeight,
        margin: EdgeInsets.only(left: Insets.med, right: Insets.med, bottom: Insets.med),
        decoration: Drawable.taskActionsDecoration(getSelectedThemeColors()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TaskActionButton(
              title: "action",
              icon: AppIcons.doneChecked,
              color: getSelectedThemeColors().iconGreen,
              onTap: () {
                taskItem.isDone = !taskItem.isDone;
                _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(taskItem));
              },
            ),
            TaskActionButton(
              title: "action",
              icon: AppIcons.changeDate,
              color: getSelectedThemeColors().accentColor,
            ),
            TaskActionButton(
              title: "action",
              icon: AppIcons.edit,
              color: getSelectedThemeColors().iconBlue,
            ),
            TaskActionButton(
              title: "action",
              icon: AppIcons.delete,
              color: getSelectedThemeColors().iconRed,
              onTap: () {
                _taskDeleteBloc.add(TaskDeleteEvent(id: taskItem.ID));
              },
            ),
          ],
        ),
      ),
    );
  }
}
