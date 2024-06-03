import 'package:ToDo/src/domain/models/setting/setting_item.dart';
import 'package:ToDo/src/domain/repositories/setting/retrieve/setting_retrieve_item_repository.dart';

class SettingRetrieveUseCase {
  late final SettingRetrieveItemRepository _repository;

  SettingRetrieveUseCase({required SettingRetrieveItemRepository repository}) {
    _repository = repository;
  }

  Future<SettingItem> invoke() {
    return _repository.getSetting();
  }
}
