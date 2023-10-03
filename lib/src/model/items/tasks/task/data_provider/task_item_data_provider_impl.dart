import '../pojo/task_item.dart';

abstract class TaskItemDataProviderImpl {
  Future<TaskItem?> getTaskByID(String taskID);

  Future<TaskItem> createOrUpdateTask(TaskItem taskItem);

  Future<List<TaskItem>> getTaskListFromData(int timestamp);

  Future<List<TaskItem>> getAllTasks();

  Future<Map<int, bool>> isAnyTaskExistInRange(int fromTimestamp, int endTimestamp);

  Future<bool> isAnyTaskExistInDate(int date);

  Future<bool> deleteTask(String taskID);

  Future<void> clear();
}
