import 'package:kardone/src/app/logic/base/parent_page_data.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';

import '../../../base/page_status.dart';

class TaskCreateUpdateBlocPageData extends ParentPageData {
  TaskItem? item;

  TaskCreateUpdateBlocPageData({required this.item, required PageStatus status})
      : super(pageStatus: status);

  TaskCreateUpdateBlocPageData copyWith({
    TaskItem? item,
    PageStatus? status,
  }) {
    return TaskCreateUpdateBlocPageData(
      item: item ?? this.item,
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus, item];
}
