import 'package:ToDo/src/app/logic/base/parent_page_data.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';

import '../../../base/page_status.dart';

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
