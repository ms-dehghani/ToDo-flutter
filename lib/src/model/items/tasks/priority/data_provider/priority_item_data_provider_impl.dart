import '../pojo/priority_item.dart';

abstract class PriorityItemDataProviderImpl {
  Future<PriorityItem?> getPriority(String priorityID);

  Future<List<PriorityItem>> getPriorities();

  Future<PriorityItem> createOrUpdatePriority(PriorityItem priorityItem);

  Future<bool> deletePriority(String priorityID);

  Future<void> clear();
}
