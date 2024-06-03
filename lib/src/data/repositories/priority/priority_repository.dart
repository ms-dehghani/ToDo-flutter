import 'package:ToDo/src/data/datasource/priority/priority_data_provider.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/repositories/priority/create/priority_create_item_repository.dart';
import 'package:ToDo/src/domain/repositories/priority/retrieve/priority_retrieve_all_items_repository.dart';

class PriorityRepository
    implements
        PriorityCreateItemRepository,
        PriorityRetrieveAllItemsRepository {
  PriorityDataProvider localDB;
  PriorityDataProvider? api;

  PriorityRepository(this.localDB, this.api);

  Future<void> clear() {
    return localDB.clear();
  }

  @override
  Future<PriorityItem> createOrUpdatePriority(PriorityItem priorityItem) {
    return localDB.createOrUpdatePriority(priorityItem);
  }

  Future<bool> deletePriority(String priorityID) {
    return localDB.deletePriority(priorityID);
  }

  @override
  Future<List<PriorityItem>> getPriorities() {
    return localDB.getPriorities();
  }

  Future<PriorityItem?> getPriority(String priorityID) {
    return localDB.getPriority(priorityID);
  }
}
