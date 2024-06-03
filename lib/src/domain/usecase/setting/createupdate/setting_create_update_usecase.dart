import 'package:ToDo/src/domain/models/setting/setting_item.dart';
import 'package:ToDo/src/domain/repositories/setting/createupdate/setting_create_update_item_repository.dart';

class SettingCreateUpdateUseCase {
  late final SettingCreateUpdateItemRepository _repository;

  SettingCreateUpdateUseCase(
      {required SettingCreateUpdateItemRepository repository}) {
    _repository = repository;
  }

  Future<void> invoke(SettingItem settingItem) {
    return _repository.setSetting(settingItem);
  }
}
