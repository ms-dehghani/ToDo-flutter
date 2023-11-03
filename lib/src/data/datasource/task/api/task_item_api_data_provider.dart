import 'package:ToDo/src/base/base_model.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';

import '../task_data_provider.dart';

class TaskItemApiDataProvider extends BaseModel implements TaskDataProvider {
  @override
  Future<TaskItem> createOrUpdateTask(TaskItem taskItem) {
    // TODO: implement createOrUpdateTask
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTask(String taskID) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<TaskItem> getTaskByID(String taskID) {
    // TODO: implement getTaskByID
    throw UnimplementedError();
  }

  @override
  Future<List<TaskItem>> getTaskListFromData(int timestamp) {
    // TODO: implement getTaskListFromData
    throw UnimplementedError();
  }

  @override
  Future<bool> isAnyTaskExistInDate(int date) {
    // TODO: implement isAnyTaskExistInDate
    throw UnimplementedError();
  }

  @override
  Future<Map<int, bool>> isAnyTaskExistInRange(int fromTimestamp, int endTimestamp) {
    // TODO: implement isAnyTaskExistInRange
    throw UnimplementedError();
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<List<TaskItem>> getAllTasks() {
    // TODO: implement getAllTasks
    throw UnimplementedError();
  }
}
