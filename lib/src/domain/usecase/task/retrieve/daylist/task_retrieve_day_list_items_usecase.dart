import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/repositories/task/retrieve/daylist/task_retrieve_day_list_items_repository.dart';

class TaskRetrieveDayListItemsUseCase {
  late final TaskRetrieveDayListItemsRepository _repository;

  TaskRetrieveDayListItemsUseCase(
      {required TaskRetrieveDayListItemsRepository repository}) {
    _repository = repository;
  }

  Future<List<TaskItem>> invoke(int timestamp) {
    return _repository.getTaskListFromData(timestamp);
  }
}
