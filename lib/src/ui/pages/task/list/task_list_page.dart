import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/src/di/di.dart';
import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_bloc.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_event.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_page_data.dart';
import 'package:kardone/src/logic/task/get/bloc/task_get_bloc.dart';
import 'package:kardone/src/logic/task/get/bloc/task_get_event.dart';
import 'package:kardone/src/logic/task/get/bloc/task_get_page_data.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/ui/pages/task/detail/task_detail_page.dart';
import 'package:kardone/src/ui/widgets/base/widget_view_template.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/ui/widgets/items/list/calender_row_item.dart';
import 'package:kardone/src/ui/widgets/progress/in_page_progress.dart';
import 'package:kardone/src/ui/widgets/items/list/task_list_row_item.dart';
import 'package:kardone/src/utils/theme_utils.dart';

import '../create/create_task_item_page.dart';

class TaskListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskListPageState();
  }
}

class _TaskListPageState extends State<TaskListPage> with WidgetViewTemplate {
  late TaskGetBloc _taskGetBloc;
  late TaskCreateOrUpdateBloc _taskCreateOrUpdateBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskGetBloc>(
          create: (BuildContext context) {
            _taskGetBloc = TaskGetBloc(taskRepository: DI.instance().getTaskRepository());
            _taskGetBloc.add(GetAllTaskInDayEvent(DateTime.now().millisecondsSinceEpoch));
            return _taskGetBloc;
          },
        ),
        BlocProvider<TaskCreateOrUpdateBloc>(
          create: (BuildContext context) => _taskCreateOrUpdateBloc =
              TaskCreateOrUpdateBloc(taskRepository: DI.instance().getTaskRepository()),
        ),
      ],
      child: Container(color: getSelectedThemeColors().pageBackground, child: showPage(context)),
    );
  }

  @override
  Widget phoneView() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return CreateTaskItemPage(
                  taskItem: TaskItem.empty(),
                );
              },
            ),
          ).then((value) {
            _taskGetBloc.add(RefreshTaskListEvent(DateTime.now().millisecondsSinceEpoch));
          });
        },
        backgroundColor: getSelectedThemeColors().primaryColor,
        child: ImageView(
          src: AppIcons.addFill,
          color: getSelectedThemeColors().textOnAccentColor,
          size: Insets.iconSize2XL,
        ),
      ),
      body: Container(
        color: getSelectedThemeColors().pageBackground,
        child: SafeArea(
          child: Column(
            children: [
              _calender(),
              Expanded(child: _taskList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calender() {
    return SizedBox(
      height: Insets.calenderListInTaskHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding:
            EdgeInsets.only(top: (Insets.calenderListInTaskHeight - Insets.calenderItemHeight) / 2),
        shrinkWrap: true,
        children: List.generate(40, growable: false, (index) {
          return CalenderRowItem(
            timestamp: DateTime.now().add(Duration(days: index)).millisecondsSinceEpoch,
            isSelected: index == 1,
          );
        }),
      ),
    );
  }

  Widget _taskList() {
    return BlocBuilder<TaskGetBloc, TaskGetBlocPageData>(
      builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(top: Insets.lg * 2),
            padding: EdgeInsets.all(Insets.med),
            color: getSelectedThemeColors().itemFillColor,
            child: state.pageStatus == PageStatus.success
                ? _taskListDetail(state.taskList)
                : _loadingWidget());
      },
    );
  }

  Widget _loadingWidget() {
    return Center(child: InPageProgress());
  }

  Widget _taskListDetail(List<TaskItem> taskList) {
    return ListView(
      shrinkWrap: true,
      children: taskList.map((e) {
        return BlocBuilder<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
          buildWhen: (previous, current) {
            return true;
            if (previous.item == null || current.item == null) return true;
            return previous.item != current.item;
          },
          builder: (context, state) {
            return TaskListRowItem(
              taskItem: e,
              onDone: (done) {
                _taskCreateOrUpdateBloc.add(TaskCreateOrUpdateEvent(e));
              },
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<TaskItem>(
                    builder: (BuildContext context) {
                      return TaskDetailPage(taskItem: e);
                    },
                  ),
                ).then((value) {
                  if (value != null) {
                    _taskGetBloc.add(RefreshTaskListEvent(DateTime.now().millisecondsSinceEpoch));
                  }
                });
              },
            );
          },
        );
      }).toList(),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.5839956);
    path_0.cubicTo(0, size.height * 0.4104515, size.width * 0.02082729, size.height * 0.2623382,
        size.width * 0.04901401, size.height * 0.2364794);
    path_0.cubicTo(size.width * 0.3934372, size.height * -0.07949706, size.width * 0.6065145,
        size.height * -0.07820441, size.width * 0.9509469, size.height * 0.2366294);
    path_0.cubicTo(size.width * 0.9791522, size.height * 0.2624088, size.width,
        size.height * 0.4105676, size.width, size.height * 0.5842029);
    path_0.lineTo(size.width, size.height * 0.5735294);
    path_0.lineTo(0, size.height * 0.5735294);
    path_0.lineTo(0, size.height * 0.5839956);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = getSelectedThemeColors().itemFillColor;
    canvas.drawShadow(path_0, getSelectedThemeColors().shadowColor, 6.0, true);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
