import 'package:ToDo/src/data/datasource/priority/priority_data_provider.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/repositories/priority/priority_item_repository.dart';

class PriorityRepository implements PriorityItemRepository {
  PriorityDataProvider localDB;
  PriorityDataProvider? api;

  PriorityRepository(this.localDB, this.api);

  @override
  Future<void> clear() {
    return localDB.clear();
  }

  @override
  Future<PriorityItem> createOrUpdatePriority(PriorityItem priorityItem) {
    return localDB.createOrUpdatePriority(priorityItem);
  }

  @override
  Future<bool> deletePriority(String priorityID) {
    return localDB.deletePriority(priorityID);
  }

  @override
  Future<List<PriorityItem>> getPriorities() {
    return localDB.getPriorities();
  }

  @override
  Future<PriorityItem?> getPriority(String priorityID) {
    return localDB.getPriority(priorityID);
  }
}
