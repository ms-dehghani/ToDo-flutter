import 'package:kardone/src/model/items/tasks/priority/pojo/priority_item.dart';
import '../data_provider/priority_item_data_provider_impl.dart';

class PriorityRepository implements PriorityItemDataProviderImpl {
  static PriorityRepository? _priorityRepository;

  static PriorityRepository init(
      PriorityItemDataProviderImpl localDB, PriorityItemDataProviderImpl? api) {
    if (_priorityRepository == null) {
      _priorityRepository = PriorityRepository._internal();
      _priorityRepository!.api = api;
      _priorityRepository!.localDB = localDB;
    }
    return _priorityRepository!;
  }

  static PriorityRepository instance() {
    return _priorityRepository!;
  }

  late PriorityItemDataProviderImpl localDB;
  PriorityItemDataProviderImpl? api;

  PriorityRepository._internal();

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
