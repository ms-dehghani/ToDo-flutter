import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/repositories/priority/create/priority_create_item_repository.dart';

class PriorityCreateUseCase {
  late final PriorityCreateItemRepository _repository;

  PriorityCreateUseCase({required PriorityCreateItemRepository repository}) {
    _repository = repository;
  }

  Future<PriorityItem> invoke(PriorityItem priorityItem) {
    return _repository.createOrUpdatePriority(priorityItem);
  }
}
