import 'package:ToDo/applic.dart';
import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/domain/models/setting/setting_item.dart';
import 'package:ToDo/src/domain/usecase/setting/createupdate/setting_create_update_usecase.dart';
import 'package:ToDo/src/domain/usecase/setting/retrieve/setting_retrieve_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'setting_change_event.dart';

class SettingBloc extends Bloc<SettingEvent, SettingItem> {
  final SettingCreateUpdateUseCase _createUpdateUseCase;
  final SettingRetrieveUseCase _retrieveUseCase;

  SettingBloc(
      {required SettingCreateUpdateUseCase createUpdateUseCase,
      required SettingRetrieveUseCase retrieveUseCase})
      : _createUpdateUseCase = createUpdateUseCase,
        _retrieveUseCase = retrieveUseCase,
        super(SettingItem(
            isDark: false, langCode: "en", pageStatus: PageStatus.initial)) {
    on<SettingChangeEvent>((event, emit) async {
      emit(event.settingItem.copyWith(status: PageStatus.loading));
      await _createUpdateUseCase.invoke(event.settingItem);
      emit(event.settingItem.copyWith(status: PageStatus.success));
      APPLIC.changeLang(event.settingItem.langCode);
      APPLIC.changeTheme(event.settingItem.isDark);
    });

    on<SettingGetEvent>((event, emit) async {
      emit(event.settingItem.copyWith(status: PageStatus.loading));
      var settingItem = await _retrieveUseCase.invoke();
      emit(settingItem.copyWith(status: PageStatus.success));
    });
  }
}
