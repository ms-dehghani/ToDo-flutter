import 'package:kardone/src/domain/repositories/priority/priority_item_repository.dart';

import '../../models/priority/priority_item.dart';

class PriorityUseCase {

  static PriorityUseCase? _useCase;

  static PriorityUseCase init(PriorityItemRepository repository) {
    return _useCase ??= PriorityUseCase._internal(repository: repository);
  }

  static PriorityUseCase instance() {
    return _useCase!;
  }

  late final PriorityItemRepository _repository;

  PriorityUseCase._internal({required PriorityItemRepository repository}) {
    _repository = repository;
  }

  Future<PriorityItem?> getPriority(String priorityID){
    return _repository.getPriority(priorityID);
  }

  Future<List<PriorityItem>> getPriorities(){
    return _repository.getPriorities();
  }

  Future<PriorityItem> createOrUpdatePriority(PriorityItem priorityItem){
    return _repository.createOrUpdatePriority(priorityItem);
  }

  Future<bool> deletePriority(String priorityID){
    return _repository.deletePriority(priorityID);
  }

  Future<void> clear(){
    return _repository.clear();
  }

}
