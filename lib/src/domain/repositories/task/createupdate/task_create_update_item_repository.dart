import 'package:ToDo/src/domain/models/task/task_item.dart';

abstract class TaskCreateUpdateItemRepository {
  Future<TaskItem> createOrUpdateTask(TaskItem taskItem);
}
