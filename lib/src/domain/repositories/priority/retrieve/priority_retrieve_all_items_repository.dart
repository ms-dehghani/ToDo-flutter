import 'package:ToDo/src/domain/models/priority/priority_item.dart';

abstract class PriorityRetrieveAllItemsRepository {
  Future<List<PriorityItem>> getPriorities();
}
