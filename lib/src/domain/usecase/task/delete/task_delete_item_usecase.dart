import 'package:ToDo/src/domain/repositories/task/delete/task_delete_item_repository.dart';

class TaskDeleteItemUseCase {
  late final TaskDeleteItemRepository _repository;

  TaskDeleteItemUseCase({required TaskDeleteItemRepository repository}) {
    _repository = repository;
  }

  Future<bool> invoke(String taskID) {
    return _repository.deleteTask(taskID);
  }
}
