import 'package:kardone/arch/base_model.dart';
import 'package:kardone/model/items/priority/pojo/priority_item.dart';

import '../priority_item_data_provider_impl.dart';

class PriorityItemApiDataProvider extends BaseModel implements PriorityItemDataProviderImpl {
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
  Future<PriorityItem> getPriority(String priorityID) {
    // TODO: implement getPriority
    throw UnimplementedError();
  }
  
}
