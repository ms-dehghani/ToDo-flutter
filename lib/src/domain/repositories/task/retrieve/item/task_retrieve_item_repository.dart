import 'package:ToDo/src/domain/models/task/task_item.dart';

abstract class TaskRetrieveItemRepository {
  Future<TaskItem?> getTaskByID(String taskID);
}
