import 'package:kardone/src/model/items/tasks/task/data_provider/task_item_data_provider_impl.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';

class TaskRepository implements TaskItemDataProviderImpl {
  static TaskRepository? _taskRepository;

  static TaskRepository init(TaskItemDataProviderImpl localDB, TaskItemDataProviderImpl? api) {
    if (_taskRepository == null) {
      _taskRepository = TaskRepository._internal();
      _taskRepository!.api = api;
      _taskRepository!.localDB = localDB;
    }
    return _taskRepository!;
  }

  static TaskRepository instance() {
    return _taskRepository!;
  }

  late TaskItemDataProviderImpl localDB;
  TaskItemDataProviderImpl? api;

  TaskRepository._internal();

  @override
  Future<void> clear() {
    return localDB.clear();
  }

  @override
  Future<TaskItem> createOrUpdateTask(TaskItem taskItem) {
    return localDB.createOrUpdateTask(taskItem);
  }

  @override
  Future<bool> deleteTask(String taskID) {
    return localDB.deleteTask(taskID);
  }

  @override
  Future<List<TaskItem>> getAllTasks() {
    return localDB.getAllTasks();
  }

  @override
  Future<TaskItem?> getTaskByID(String taskID) {
    return localDB.getTaskByID(taskID);
  }

  @override
  Future<List<TaskItem>> getTaskListFromData(int timestamp) {
    return localDB.getTaskListFromData(timestamp);
  }

  @override
  Future<bool> isAnyTaskExistInDate(int date) {
    return localDB.isAnyTaskExistInDate(date);
  }

  @override
  Future<Map<int, bool>> isAnyTaskExistInRange(int fromTimestamp, int endTimestamp) {
    return localDB.isAnyTaskExistInRange(fromTimestamp, endTimestamp);
  }
}
