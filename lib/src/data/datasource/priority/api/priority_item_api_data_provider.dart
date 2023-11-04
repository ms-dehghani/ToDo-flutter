import 'package:ToDo/src/base/base_model.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';

import '../priority_data_provider.dart';

class PriorityItemApiDataProvider extends BaseModel implements PriorityDataProvider {
  @override
  Future<PriorityItem> createOrUpdatePriority(PriorityItem priorityItem) {
    // TODO: implement createOrUpdatePriority
    throw UnimplementedError();
  }

  @override
  Future<bool> deletePriority(String priorityID) {
    // TODO: implement deletePriority
    throw UnimplementedError();
  }

  @override
  Future<List<PriorityItem>> getPriorities() {
    // TODO: implement getPriorities
    throw UnimplementedError();
  }

  @override
  Future<PriorityItem?> getPriority(String priorityID) {
    // TODO: implement getPriority
    throw UnimplementedError();
  }

  @override
  Future<void> clear() async {
    throw UnimplementedError();
  }
}
