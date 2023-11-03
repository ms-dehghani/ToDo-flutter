import 'package:ToDo/src/base/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../setting_data_provider.dart';

class SettingItemDataProvider extends BaseModel implements SettingDataProvider {
  final SharedPreferences _preferences;

  static SettingItemDataProvider? _singleton;

  factory SettingItemDataProvider(SharedPreferences preferences) {
    _singleton ??= SettingItemDataProvider._internal(preferences);
    return _singleton!;
  }

  SettingItemDataProvider._internal(this._preferences);

  final String theme = "THEME";
  final String langCode = "LANG_CODE";

  @override
  Future<String> getLanguage() async {
    return Future(() => _preferences.getString(langCode)!);
  }

  @override
  Future<bool> getTheme() async {
    return Future(() {
      var isDark = _preferences.getBool(theme) ?? false;
      return isDark;
    });
  }

  @override
  Future<void> setLanguage(String lang) async {
    await _preferences.setString(langCode, lang);
  }

  @override
  Future<void> setTheme(bool isDark) async {
    await _preferences.setBool(theme, isDark);
  }

  @override
  Future<void> clear() async {
    await _preferences.clear();
  }
}
