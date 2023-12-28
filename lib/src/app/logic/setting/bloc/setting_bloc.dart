import 'package:ToDo/applic.dart';
import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/domain/models/setting/setting_item.dart';
import 'package:ToDo/src/domain/usecase/setting/setting_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'setting_change_event.dart';

class SettingBloc extends Bloc<SettingEvent, SettingItem> {
  final SettingUseCase _settingUseCase;

  SettingBloc({required SettingUseCase settingUseCase})
      : _settingUseCase = settingUseCase,
        super(SettingItem(isDark: false, langCode: "en", pageStatus: PageStatus.initial)) {
    on<SettingChangeEvent>((event, emit) async {
      emit(event.settingItem.copyWith(status: PageStatus.loading));
      await _settingUseCase.setSetting(event.settingItem);
      emit(event.settingItem.copyWith(status: PageStatus.success));
      APPLIC.changeLang(event.settingItem.langCode);
    });

    on<SettingGetEvent>((event, emit) async {
      emit(event.settingItem.copyWith(status: PageStatus.loading));
      var settingItem = await _settingUseCase.getSetting();
      emit(settingItem.copyWith(status: PageStatus.success));
    });
  }
}
