import '../../models/setting/setting_item.dart';
import '../../repositories/setting/setting_item_repository.dart';

class SettingUseCase {
  late final SettingItemRepository _repository;

  SettingUseCase({required SettingItemRepository repository}) {
    _repository = repository;
  }

  Future<void> setSetting(SettingItem settingItem) {
    return _repository.setSetting(settingItem);
  }

  Future<SettingItem> getSetting() {
    return _repository.getSetting();
  }
}
