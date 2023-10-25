import 'package:kardone/src/domain/repositories/task/task_item_repository.dart';

import '../../models/task/task_item.dart';

class TaskUseCase {

  late final TaskItemRepository _repository;

  TaskUseCase({required TaskItemRepository repository}) {
    _repository = repository;
  }

  Future<TaskItem?> getTaskByID(String taskID) {
    return _repository.getTaskByID(taskID);
  }

  Future<TaskItem> createOrUpdateTask(TaskItem taskItem) {
    return _repository.createOrUpdateTask(taskItem);
  }

  Future<List<TaskItem>> getTaskListFromData(int timestamp) {
    return _repository.getTaskListFromData(timestamp);
  }

  Future<List<TaskItem>> getAllTasks() {
    return _repository.getAllTasks();
  }

  Future<Map<int, bool>> isAnyTaskExistInRange(int fromTimestamp, int endTimestamp) {
    return _repository.isAnyTaskExistInRange(fromTimestamp, endTimestamp);
  }

  Future<bool> isAnyTaskExistInDate(int date) {
    return _repository.isAnyTaskExistInDate(date);
  }

  Future<bool> deleteTask(String taskID) {
    return _repository.deleteTask(taskID);
  }

  Future<void> clear() {
    return _repository.clear();
  }
}
