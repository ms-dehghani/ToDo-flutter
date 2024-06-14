import 'package:ToDo/src/domain/models/setting/setting_item.dart';

abstract class SettingRetrieveItemRepository {
  Future<SettingItem> getSetting();
}
