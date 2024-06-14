import 'package:ToDo/src/domain/models/priority/priority_item.dart';

abstract class PriorityCreateItemRepository {
  Future<PriorityItem> createOrUpdatePriority(PriorityItem priorityItem);
}
