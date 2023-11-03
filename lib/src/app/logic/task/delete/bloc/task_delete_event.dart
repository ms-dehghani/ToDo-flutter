import 'package:ToDo/src/domain/models/task/task_item.dart';

class TaskDeleteEvent {
  late String taskID;

  TaskDeleteEvent({TaskItem? item, String? id}) {
    taskID = item?.ID ?? id ?? "";
  }
}
