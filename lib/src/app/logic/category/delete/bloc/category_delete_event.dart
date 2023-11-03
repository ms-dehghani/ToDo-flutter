import 'package:ToDo/src/domain/models/task/task_item.dart';

class CategoryDeleteEvent {
  late String taskID;

  CategoryDeleteEvent({TaskItem? item, String? id}) {
    taskID = item?.ID ?? id ?? "";
  }
}
