import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/base/parent_page_data.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';

class TaskGetBlocPageData extends ParentPageData {
  List<TaskItem> taskList;
  Map<int, bool> calenderDetail;

  TaskGetBlocPageData(
      {this.taskList = const [], this.calenderDetail = const {}, required PageStatus status})
      : super(pageStatus: status);

  TaskGetBlocPageData copyWith({
    PageStatus? status,
    List<TaskItem>? taskList,
    Map<int, bool>? calenderDetail,
  }) {
    return TaskGetBlocPageData(
      taskList: taskList ?? this.taskList,
      status: status ?? pageStatus,
      calenderDetail: calenderDetail ?? this.calenderDetail,
    );
  }

  @override
  List<Object?> get props => [pageStatus, taskList, calenderDetail];
}
