import 'package:kardone/arch/base_model.dart';

import '../../pojo/task_item.dart';
import '../task_item_data_provider_impl.dart';

class TaskItemApiDataProvider extends BaseModel implements TaskItemDataProviderImpl {
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
}
