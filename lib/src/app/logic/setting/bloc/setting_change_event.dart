import 'package:ToDo/src/domain/models/setting/setting_item.dart';

sealed class SettingEvent {
  SettingItem settingItem;

  SettingEvent(this.settingItem);
}

class SettingChangeEvent extends SettingEvent {
  SettingChangeEvent(super.settingItem);
}

class SettingGetEvent extends SettingEvent {
  SettingGetEvent(super.settingItem);
}
