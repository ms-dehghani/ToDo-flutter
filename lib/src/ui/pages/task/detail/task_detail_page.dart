import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/res/texts.dart';
import 'package:kardone/src/di/di.dart';
import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_bloc.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_event.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_page_data.dart';
import 'package:kardone/src/logic/task/delete/bloc/task_delete_bloc.dart';
import 'package:kardone/src/logic/task/delete/bloc/task_delete_page_data.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/ui/pages/task/create/create_task_item_page.dart';
import 'package:kardone/src/ui/widgets/app_bar.dart';
import 'package:kardone/src/ui/widgets/base/widget_view_template.dart';
import 'package:kardone/src/ui/widgets/bottomsheet/round_bottom_sheet.dart';
import 'package:kardone/src/ui/widgets/buttons/back_button.dart';
import 'package:kardone/src/ui/widgets/buttons/task_action_button.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/ui/widgets/items/detail/task_detail_row_item.dart';
import 'package:kardone/src/utils/extentions/translates_string_extentions.dart';
import 'package:kardone/src/utils/navigator.dart';
import 'package:kardone/src/utils/theme_utils.dart';
import 'package:kardone/src/utils/time_util.dart';

class TaskDetailPage extends StatelessWidget with WidgetViewTemplate {
  TaskItem taskItem;

  TaskDetailPage({super.key, required this.taskItem});

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
      child: BlocBuilder<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
        buildWhen: (previous, current) {
          return true;
        },
        builder: (context, state) {
          return Container(
              color: getSelectedThemeColors().pageBackground, child: showPage(context));
        },
      ),
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
                  Texts.taskDetailPageTitle.translate,
                  style: TextStyles.h2Bold.copyWith(color: getSelectedThemeColors().primaryColor),
                )),
            Expanded(child: _taskDetail()),
            _taskActions(context)
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
        Visibility(
          visible: taskItem.description.isNotEmpty,
          child: TaskDetailRowItem(
            title: Texts.addTaskRowDescription.translate,
            icon: AppIcons.descriptionFill,
            titleColor: getSelectedThemeColors().iconPink,
            child: Text(
              taskItem.description,
              style: TextStyles.h2.copyWith(color: getSelectedThemeColors().secondaryText),
            ),
          ),
        ),
      ],
    );
  }

  Widget _taskTitle() {
    return Container(
      padding: EdgeInsets.all(Insets.pagePadding),
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
        ItemSplitter.ultraThinSplitter,
        Text(
          Texts.taskDetailPagePriority.translate,
          style: TextStyles.h3.copyWith(color: taskItem.priorityItem?.color),
        ),
        ItemSplitter.ultraThinSplitter,
        Text(
          taskItem.priorityItem?.title.translate ?? "",
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
        ItemSplitter.ultraThinSplitter,
        Text(
          Texts.taskDetailPageCategory.translate,
          style: TextStyles.h3.copyWith(color: getSelectedThemeColors().iconBlue),
        ),
        ItemSplitter.ultraThinSplitter,
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
            ItemSplitter.ultraThinSplitter,
            ItemSplitter.ultraThinSplitter,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Texts.addTaskRowDescription.translate,
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

  Widget _taskActions(BuildContext context) {
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
        margin: EdgeInsets.only(
            left: Insets.pagePadding, right: Insets.pagePadding, bottom: Insets.pagePadding),
        decoration: Drawable.taskActionsDecoration(getSelectedThemeColors()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _taskActionDone(),
            _taskActionChangeDate(context),
            _taskActionEdit(context),
            _taskActionDelete(context),
          ],
        ),
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
        _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(taskItem));
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
          _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(taskItem));
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
            )).then((value) => _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(taskItem)));
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
          // _taskDeleteBloc.add(TaskDeleteEvent(id: taskItem.ID));
        }, text: Texts.taskDetailPageCategory);
      },
    );
  }
}
