import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';

class CategoryDeleteEvent {
  late String taskID;

  CategoryDeleteEvent({TaskItem? item, String? id}) {
    taskID = item?.ID ?? id ?? "";
  }
}
