import '../../models/setting/setting_item.dart';

abstract class SettingItemRepository {
  Future<void> setSetting(SettingItem settingItem);

  Future<SettingItem> getSetting();
}
