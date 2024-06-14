import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/repositories/task/createupdate/task_create_update_item_repository.dart';

class TaskCreateUpdateUseCase {
  late final TaskCreateUpdateItemRepository _repository;

  TaskCreateUpdateUseCase(
      {required TaskCreateUpdateItemRepository repository}) {
    _repository = repository;
  }

  Future<TaskItem> invoke(TaskItem taskItem) {
    return _repository.createOrUpdateTask(taskItem);
  }
}
