import 'package:ToDo/src/domain/models/setting/setting_item.dart';

abstract class SettingCreateUpdateItemRepository {
  Future<void> setSetting(SettingItem settingItem);
}
