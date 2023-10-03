import 'package:kardone/src/logic/setting/pojo/setting_item.dart';

import 'setting_change_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBloc extends Bloc<SettingChangeEvent, SettingItem> {
  SettingBloc(super.initialState) {
    on<SettingChangeEvent>((event, emit) async {
      emit(event.settingItem);
    });
  }
}
