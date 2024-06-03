import 'package:ToDo/src/domain/models/task/task_item.dart';

abstract class TaskRetrieveDayListItemsRepository {
  Future<List<TaskItem>> getTaskListFromData(int timestamp);
}
