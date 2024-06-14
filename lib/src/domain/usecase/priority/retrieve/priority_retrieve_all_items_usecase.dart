import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/repositories/priority/retrieve/priority_retrieve_all_items_repository.dart';

class PriorityRetrieveAllItemsUseCase {
  late final PriorityRetrieveAllItemsRepository _repository;

  PriorityRetrieveAllItemsUseCase(
      {required PriorityRetrieveAllItemsRepository repository}) {
    _repository = repository;
  }

  Future<List<PriorityItem>> invoke() {
    return _repository.getPriorities();
  }
}
