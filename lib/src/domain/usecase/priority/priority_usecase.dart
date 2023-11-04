import 'package:ToDo/src/domain/repositories/priority/priority_item_repository.dart';

import '../../models/priority/priority_item.dart';

class PriorityUseCase {


  late final PriorityItemRepository _repository;

  PriorityUseCase({required PriorityItemRepository repository}) {
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
