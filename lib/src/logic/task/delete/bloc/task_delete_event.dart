import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';

class TaskDeleteEvent {
  late String taskID;

  TaskDeleteEvent({TaskItem? item, String? id}) {
    taskID = item?.ID ?? id ?? "";
  }
}
