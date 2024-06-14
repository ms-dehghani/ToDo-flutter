import 'package:ToDo/src/data/datasource/task/task_data_provider.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/repositories/task/createupdate/task_create_update_item_repository.dart';
import 'package:ToDo/src/domain/repositories/task/delete/task_delete_item_repository.dart';
import 'package:ToDo/src/domain/repositories/task/existence/task_check_existence_repository.dart';
import 'package:ToDo/src/domain/repositories/task/retrieve/daylist/task_retrieve_day_list_items_repository.dart';
import 'package:ToDo/src/domain/repositories/task/retrieve/item/task_retrieve_item_repository.dart';

class TaskRepository
    implements
        TaskCreateUpdateItemRepository,
        TaskDeleteItemRepository,
        TaskRetrieveDayListItemsRepository,
        TaskRetrieveItemRepository,
        TaskCheckExistenceRepository {
  TaskDataProvider localDB;
  TaskDataProvider? api;

  TaskRepository(this.localDB, this.api);

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

  Future<bool> isAnyTaskExistInDate(int date) {
    return localDB.isAnyTaskExistInDate(date);
  }

  @override
  Future<Map<int, bool>> isAnyTaskExistInRange(
      int fromTimestamp, int endTimestamp) {
    return localDB.isAnyTaskExistInRange(fromTimestamp, endTimestamp);
  }
}
