import 'package:ToDo/src/domain/models/task/task_item.dart';

class TaskCreateOrUpdateEvent {
  TaskItem taskItem;

  TaskCreateOrUpdateEvent(this.taskItem);
}
