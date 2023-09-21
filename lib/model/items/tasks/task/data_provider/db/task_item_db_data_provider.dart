import 'package:kardone/arch/base_model.dart';
import 'package:kardone/model/items/tasks/category/data_provider/db/category_item_db_data_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../category/data_provider/category_item_data_provider_impl.dart';
import '../../../priority/data_provider/db/priority_item_db_data_provider.dart';
import '../../../priority/data_provider/priority_item_data_provider_impl.dart';
import '../../pojo/task_item.dart';
import '../../pojo/task_static.dart';
import '../task_item_data_provider_impl.dart';

class TaskItemDBDataProvider extends BaseModel implements TaskItemDataProviderImpl {
  final Database _database;

  final String tableName = "Tasks";

  final CategoryItemDataProviderImpl _categoryItemDataProvider;
  final PriorityItemDataProviderImpl _priorityItemDataProvider;

  TaskItemDBDataProvider(
      this._database, this._categoryItemDataProvider, this._priorityItemDataProvider) {
    _database.execute("create table if not exists $tableName ($filedId TEXT PRIMARY KEY,"
        "$filedTitle TEXT, $filedDescription TEXT, $filedTimestamp INTEGER ,$filedDone INTEGER,"
        "$filedCategoryID TEXT,$filedPriorityID TEXT ))");
  }

  @override
  Future<TaskItem> createOrUpdateTask(TaskItem taskItem) async {
    int id = await _database.insert(tableName, taskItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (taskItem.ID.isEmpty) taskItem.ID = id.toString();
    return taskItem;
  }

  @override
  Future<bool> deleteTask(String taskID) async {
    int result = await _database.delete(tableName, where: "$filedId = ?", whereArgs: [taskID]);
    return result > 0;
  }

  @override
  Future<TaskItem?> getTaskByID(String taskID) async {
    List<Map> list = await _database.query(
      tableName,
      columns: TaskItem.empty().toMap().keys.toList(),
      where: "$filedId = ?",
      whereArgs: [taskID],
    );
    return list.isEmpty ? null : await _getItemFromMap(list[0]);
  }

  @override
  Future<List<TaskItem>> getTaskListFromData(int timestamp) async {
    var time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    List<Map> list = await _database.query(
      tableName,
      columns: TaskItem.empty().toMap().keys.toList(),
      where: "$filedTimestamp > ? and $filedTimestamp < ?",
      whereArgs: [
        time.copyWith(hour: 0, minute: 0, second: 1).millisecondsSinceEpoch,
        time.copyWith(hour: 23, minute: 59, second: 59).millisecondsSinceEpoch
      ],
    );
    List<TaskItem> result = [];
    if (list.isNotEmpty) {
      for (var item in list) {
        result.add(await _getItemFromMap(item));
      }
    }
    return result;
  }

  @override
  Future<bool> isAnyTaskExistInDate(int timestamp) async {
    var time = DateTime.fromMillisecondsSinceEpoch(timestamp);

    List<Map> list = await _database.query(tableName,
        columns: TaskItem.empty().toMap().keys.toList(),
        where: "$filedTimestamp > ? and $filedTimestamp < ?",
        whereArgs: [
          time.copyWith(hour: 0, minute: 0, second: 1).millisecondsSinceEpoch,
          time.copyWith(hour: 23, minute: 59, second: 59).millisecondsSinceEpoch
        ],
        limit: 1);
    return list.isNotEmpty;
  }

  @override
  Future<Map<int, bool>> isAnyTaskExistInRange(int fromTimestamp, int endTimestamp) async {
    var startTime = DateTime.fromMillisecondsSinceEpoch(fromTimestamp);
    var endTime = DateTime.fromMillisecondsSinceEpoch(endTimestamp);

    List<Map> list = await _database.query(
      tableName,
      columns: [filedTimestamp],
      where: "$filedTimestamp > ? and $filedTimestamp < ?",
      whereArgs: [
        startTime.copyWith(hour: 0, minute: 0, second: 1).millisecondsSinceEpoch,
        endTime.copyWith(hour: 23, minute: 59, second: 59).millisecondsSinceEpoch
      ],
    );
    Map<int, bool> result = {};
    if (list.isNotEmpty) {
      for (var item in list) {
        int timestamp = item[filedTimestamp];
        var date =
            DateTime.fromMillisecondsSinceEpoch(timestamp).copyWith(hour: 0, minute: 0, second: 10);
        result.putIfAbsent(date.millisecondsSinceEpoch, () => true);
      }
    }
    return result;
  }

  Future<TaskItem> _getItemFromMap(Map map) async {
    var result = TaskItem.fromMap(map);
    await _setCategoryToItem(result, map[filedCategoryID]);
    await _setPriorityItemToItem(result, map[filedPriorityID]);
    return result;
  }

  Future<void> _setCategoryToItem(TaskItem taskItem, String catID) async {
    taskItem.categoryItem = await _categoryItemDataProvider.getCategory(catID);
  }

  Future<void> _setPriorityItemToItem(TaskItem taskItem, String priorityID) async {
    taskItem.priorityItem = await _priorityItemDataProvider.getPriority(priorityID);
  }
}
