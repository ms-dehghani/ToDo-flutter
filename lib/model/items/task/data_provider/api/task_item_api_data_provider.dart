import 'package:kardone/arch/base_model.dart';
import 'package:kardone/model/items/task/pojo/task_item.dart';

import '../task_item_data_provider_impl.dart';

class TaskItemApiDataProvider extends BaseModel implements TaskItemDataProviderImpl {
  @override
  TaskItem createOrUpdateTask(TaskItem taskItem) {
    // TODO: implement createOrUpdateTask
    throw UnimplementedError();
  }

  @override
  bool deleteTask(String taskID) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  TaskItem getTask(String taskID) {
    // TODO: implement getTask
    throw UnimplementedError();
  }
}
