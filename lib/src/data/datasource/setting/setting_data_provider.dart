abstract class SettingDataProvider {
  Future<void> setTheme(bool isDark);

  Future<bool> getTheme();

  Future<void> setLanguage(String lang);

  Future<String> getLanguage();

  Future<void> clear();
}
