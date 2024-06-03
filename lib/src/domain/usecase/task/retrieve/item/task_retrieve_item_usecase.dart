import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/repositories/task/retrieve/item/task_retrieve_item_repository.dart';

class TaskRetrieveItemUseCase {
  late final TaskRetrieveItemRepository _repository;

  TaskRetrieveItemUseCase({required TaskRetrieveItemRepository repository}) {
    _repository = repository;
  }

  Future<TaskItem?> invoke(String taskID) {
    return _repository.getTaskByID(taskID);
  }
}
