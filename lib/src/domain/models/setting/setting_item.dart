import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/base/parent_page_data.dart';

class SettingItem extends ParentPageData {
  bool isDark;
  String langCode;

  SettingItem({required this.isDark, required this.langCode, required super.pageStatus});

  SettingItem copyWith({
    PageStatus? status,
    bool? isDark,
    String? langCode,
  }) {
    return SettingItem(
      isDark: isDark ?? this.isDark,
      pageStatus: status ?? pageStatus,
      langCode: langCode ?? this.langCode,
    );
  }

  @override
  List<Object?> get props => [pageStatus, langCode, isDark];
}
