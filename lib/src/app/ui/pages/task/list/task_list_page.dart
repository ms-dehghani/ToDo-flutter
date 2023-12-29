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
import 'package:ToDo/src/app/logic/task/get/bloc/task_get_bloc.dart';
import 'package:ToDo/src/app/logic/task/get/bloc/task_get_event.dart';
import 'package:ToDo/src/app/logic/task/get/bloc/task_get_page_data.dart';
import 'package:ToDo/src/app/ui/pages/task/detail/task_detail_page.dart';
import 'package:ToDo/src/app/ui/widgets/base/widget_view_template.dart';
import 'package:ToDo/src/app/ui/widgets/calendar_view/calendar_view.dart';
import 'package:ToDo/src/app/ui/widgets/image/image_view.dart';
import 'package:ToDo/src/app/ui/widgets/items/list/task_list_row_item.dart';
import 'package:ToDo/src/app/ui/widgets/progress/in_page_progress.dart';
import 'package:ToDo/src/app/ui/widgets/round_rect/custom_round_navigation_background.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/utils/device.dart';
import 'package:ToDo/src/utils/extensions/date_extensions.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/navigator.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:ToDo/src/utils/time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListPage extends StatelessWidget with WidgetViewTemplate {
  final TaskGetBloc _taskGetBloc = TaskGetBloc(taskUseCase: DI.instance().getTaskUseCase());

  final TaskCreateOrUpdateBloc _taskCreateOrUpdateBloc =
      TaskCreateOrUpdateBloc(taskUseCase: DI.instance().getTaskUseCase());

  final TaskDeleteBloc _taskDeleteBloc =
      TaskDeleteBloc(taskUseCase: DI.instance().getTaskUseCase());

  DateTime selectedDay = DateTime.now();

  TaskListPage({super.key});

  void reload() {
    _taskGetBloc.add(GetAllTaskInDayEvent(selectedDay.millisecondsSinceEpoch));
  }

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    _taskGetBloc.add(GetAllTaskInDayEvent(selectedDay.millisecondsSinceEpoch));
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskGetBloc>(
          create: (BuildContext context) => _taskGetBloc,
        ),
        BlocProvider<TaskCreateOrUpdateBloc>(
          create: (BuildContext context) => _taskCreateOrUpdateBloc,
        ),
        BlocProvider<TaskDeleteBloc>(
          create: (BuildContext context) => _taskDeleteBloc,
        ),
      ],
      child: Container(
          color: getSelectedThemeColors(context).pageBackground, child: showPage(context)),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return Scaffold(
      body: Container(
        color: isDark()
            ? getSelectedThemeColors(context).onBackground
            : getSelectedThemeColors(context).pageBackground,
        child: SafeArea(
          child: Stack(
            children: [
              _calender(),
              Padding(
                padding: EdgeInsets.only(top: Insets.calenderListInTaskHeight - Insets.sm),
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(getWidth(context), Insets.buttonHeight * 1.5),
                      painter: CustomRoundNavigationBackground(
                          context, getSelectedThemeColors(context).itemFillColor),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Insets.xl),
                      child: Container(
                        width: getWidth(context),
                        height: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
                        color: isDark()
                            ? getSelectedThemeColors(context).pageBackground
                            : getSelectedThemeColors(context).onBackground,
                        child: Text(Texts.taskListTitle.translate,
                            style: TextStyles.h1Bold
                                .copyWith(color: getSelectedThemeColors(context).primaryColor)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: Insets.lg), child: _taskList()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calender() {
    return CalenderView(
      start: DateTime.now().subtract(Duration(days: 150)),
      end: DateTime.now().add(Duration(days: 150)),
      onSelect: (dateTime) {
        selectedDay = dateTime;
        _taskGetBloc.add(GetAllTaskInDayEvent(selectedDay.millisecondsSinceEpoch));
      },
    );
  }

  Widget _taskList() {
    return BlocListener<TaskDeleteBloc, TaskDeleteBlocPageData>(
      listener: (context, state) {
        _taskGetBloc.add(GetAllTaskInDayEvent(selectedDay.millisecondsSinceEpoch));
      },
      child: BlocBuilder<TaskGetBloc, TaskGetBlocPageData>(
        buildWhen: (previous, current) {
          return previous.pageStatus != current.pageStatus;
        },
        bloc: _taskGetBloc,
        builder: (context, state) {
          return Container(
              margin: EdgeInsets.only(top: Insets.buttonHeight),
              height: double.infinity,
              child: state.pageStatus == PageStatus.success
                  ? (state.taskList.isNotEmpty ? _taskListDetail(state.taskList) : _emptyView())
                  : _loadingWidget());
        },
      ),
    );
  }

  Widget _loadingWidget() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: isDark()
            ? getSelectedThemeColors(context).pageBackground
            : getSelectedThemeColors(context).onBackground,
        child: Center(child: InPageProgress()));
  }

  Widget _taskListDetail(List<TaskItem> taskList) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
      children: taskList.map((e) {
        return BlocBuilder<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
          buildWhen: (previous, current) {
            return current.pageStatus == PageStatus.success;
          },
          bloc: _taskCreateOrUpdateBloc,
          builder: (context, state) {
            if (!selectedDay.isSameDay(timestamp: e.taskTimestamp)) {
              _taskGetBloc.add(GetAllTaskInDayEvent(selectedDay.millisecondsSinceEpoch));
              return Container();
            }
            return TaskListRowItem(
              key: GlobalKey(),
              taskItem: e,
              onDone: (done) {
                _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(e));
              },
              onTap: () {
                navigateToPage(
                    context,
                    TaskDetailPage(
                      taskItem: e,
                    )).then((value) {
                  _taskGetBloc.add(RefreshTaskListEvent(selectedDay.millisecondsSinceEpoch));
                });
              },
              onEdit: () {
                _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(e));
              },
              onChangeDate: () {
                _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(e));
              },
              onDelete: () {
                _taskDeleteBloc.add(TaskDeleteEvent(id: e.ID));
              },
            );
          },
        );
      }).toList(),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        children: [
          ItemSplitter.thickSplitter,
          RichText(
            text: TextSpan(
              style: TextStyles.h3.copyWith(color: getSelectedThemeColors(context).primaryText),
              children: <TextSpan>[
                TextSpan(text: Texts.taskEmptyMessage.translate.split("%")[0]),
                TextSpan(
                    text:
                        " «${selectedDay.isSameDay(date: DateTime.now()) ? Texts.today.translate : fullTimeToText(selectedDay.millisecondsSinceEpoch)}» ",
                    style: TextStyles.h3Bold
                        .copyWith(color: getSelectedThemeColors(context).primaryText)),
                TextSpan(text: Texts.taskEmptyMessage.translate.split("%")[1]),
              ],
            ),
          ),
          ImageView(src: AppIcons.emptyTask, size: Insets.emptyImageSize),
        ],
      ),
    );
  }
}
