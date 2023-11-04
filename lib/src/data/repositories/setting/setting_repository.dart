import 'package:ToDo/src/domain/models/setting/setting_item.dart';
import 'package:ToDo/src/domain/repositories/setting/setting_item_repository.dart';

import '../../datasource/setting/setting_data_provider.dart';

class SettingRepository implements SettingItemRepository {
  SettingDataProvider dataProvider;

  SettingRepository(this.dataProvider);

  @override
  Future<SettingItem> getSetting() async {
    var theme = await dataProvider.getTheme();
    var langCode = await dataProvider.getLanguage();
    return Future(() => SettingItem(isDark: theme, langCode: langCode));
  }

  @override
  Future<void> setSetting(SettingItem settingItem) async {
    await dataProvider.setTheme(settingItem.isDark);
    await dataProvider.setLanguage(settingItem.langCode);
  }
}
