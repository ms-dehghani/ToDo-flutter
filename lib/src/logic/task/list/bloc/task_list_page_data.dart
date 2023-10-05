import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/base/parent_page_data.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';

class TaskListPageData extends ParentPageData {
  List<TaskItem> taskList;
  Map<int, bool> calenderDetail;

  TaskListPageData(
      {this.taskList = const [], this.calenderDetail = const {}, required PageStatus status})
      : super(pageStatus: status);

  TaskListPageData copyWith({
    PageStatus? status,
    List<TaskItem>? taskList,
    Map<int, bool>? calenderDetail,
  }) {
    return TaskListPageData(
      taskList: taskList ?? this.taskList,
      status: status ?? pageStatus,
      calenderDetail: calenderDetail ?? this.calenderDetail,
    );
  }
}
