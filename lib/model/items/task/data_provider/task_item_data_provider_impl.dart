
import '../pojo/task_item.dart';

abstract class TaskItemDataProviderImpl{

  TaskItem getTask(String taskID);

  TaskItem createOrUpdateTask(TaskItem taskItem);

  bool deleteTask(String taskID);

}