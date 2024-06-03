import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/res/texts.dart';
import 'package:ToDo/src/app/di/di.dart';
import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_bloc.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_event.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_page_data.dart';
import 'package:ToDo/src/app/logic/task/delete/bloc/task_delete_bloc.dart';
import 'package:ToDo/src/app/logic/task/delete/bloc/task_delete_event.dart';
import 'package:ToDo/src/app/logic/task/delete/bloc/task_delete_page_data.dart';
import 'package:ToDo/src/app/ui/widgets/app_bar.dart';
import 'package:ToDo/src/app/ui/widgets/base/widget_view_template.dart';
import 'package:ToDo/src/app/ui/widgets/buttons/back_button.dart';
import 'package:ToDo/src/app/ui/widgets/image/image_view.dart';
import 'package:ToDo/src/app/ui/widgets/items/detail/task_detail_row_item.dart';
import 'package:ToDo/src/app/ui/widgets/items/task/task_actions.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:ToDo/src/utils/time_util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailPage extends StatelessWidget with WidgetViewTemplate {
  TaskItem taskItem;

  TaskDetailPage({super.key, required this.taskItem});

  final TaskCreateOrUpdateBloc _taskCreateOrUpdateBloc = TaskCreateOrUpdateBloc(
      createUpdateUseCase: DI.instance().getTaskCreateUpdateUseCase());

  final TaskDeleteBloc _taskDeleteBloc = TaskDeleteBloc(
      taskDeleteItemUseCase: DI.instance().getTaskDeleteUseCase());

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCreateOrUpdateBloc>(
          create: (BuildContext context) => _taskCreateOrUpdateBloc,
        ),
        BlocProvider<TaskDeleteBloc>(
          create: (BuildContext context) => _taskDeleteBloc,
        ),
      ],
      child: BlocBuilder<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
        buildWhen: (previous, current) {
          return previous.pageStatus != current.pageStatus;
        },
        builder: (context, state) {
          return Container(
              color: isDark()
                  ? getSelectedThemeColors().pageBackground
                  : getSelectedThemeColors().onBackground,
              child: showPage(context));
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
                  style: TextStyles.h2Bold
                      .copyWith(color: getSelectedThemeColors().primaryColor),
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
              style: TextStyles.h2
                  .copyWith(color: getSelectedThemeColors().secondaryText),
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
            style: TextStyles.h1Bold
                .copyWith(color: getSelectedThemeColors().primaryText),
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
          style:
              TextStyles.h3Bold.copyWith(color: taskItem.priorityItem?.color),
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
          style:
              TextStyles.h3.copyWith(color: getSelectedThemeColors().iconBlue),
        ),
        ItemSplitter.ultraThinSplitter,
        Text(
          taskItem.categoryItem?.title ?? "",
          style: TextStyles.h3Bold
              .copyWith(color: getSelectedThemeColors().iconBlue),
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
            left: Insets.pagePadding,
            right: Insets.pagePadding,
            bottom: Insets.pagePadding),
        decoration: Drawable.taskActionsDecoration(getSelectedThemeColors()),
        child: TaskActions(
            taskItem: taskItem,
            onDone: () {
              _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(taskItem));
            },
            onChangeDate: () {
              _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(taskItem));
            },
            onDelete: () {
              _taskDeleteBloc.add(TaskDeleteEvent(id: taskItem.ID));
            },
            onEdit: () {
              _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(taskItem));
            }),
      ),
    );
  }
}
