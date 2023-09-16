import 'package:kardone/arch/base_model.dart';
import 'package:kardone/model/items/task/pojo/task_item.dart';
import 'package:sqflite/sqflite.dart';

import '../task_item_data_provider_impl.dart';

class TaskItemDBDataProvider extends BaseModel implements TaskItemDataProviderImpl {

  Database _database;

  final String _tableName = "Tasks";


  TaskItemDBDataProvider(this._database){
    _database.execute("create table if not exists $_tableName ()");
  }

  @override
  TaskItem createOrUpdateTask(TaskItem taskItem) {
    // return repo.createOrUpdateTask(taskItem);
    return taskItem;
  }

  @override
  bool deleteTask(String taskID) {
    // return repo.deleteTask(taskID);
    return true;
  }

  @override
  TaskItem getTask(String taskID) {
    // return repo.getTask(taskID);
    return TaskItem.empty();
  }
}
