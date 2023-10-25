import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';

class TaskCreateOrUpdateEvent {
  TaskItem taskItem;

  TaskCreateOrUpdateEvent(this.taskItem);
}
