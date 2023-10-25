
import 'package:kardone/src/domain/models/priority/priority_item.dart';

abstract class PriorityDataProvider {
  Future<PriorityItem?> getPriority(String priorityID);

  Future<List<PriorityItem>> getPriorities();

  Future<PriorityItem> createOrUpdatePriority(PriorityItem priorityItem);

  Future<bool> deletePriority(String priorityID);

  Future<void> clear();
}
