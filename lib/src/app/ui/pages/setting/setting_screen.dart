import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/res/texts.dart';
import 'package:ToDo/src/app/di/di.dart';
import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/setting/bloc/setting_bloc.dart';
import 'package:ToDo/src/app/logic/setting/bloc/setting_change_event.dart';
import 'package:ToDo/src/app/ui/widgets/image/image_view.dart';
import 'package:ToDo/src/domain/models/setting/setting_item.dart';
import 'package:ToDo/src/utils/direction_util.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/base/widget_view_template.dart';
import '../../widgets/switch/switch_view.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with WidgetViewTemplate {
  final SettingBloc _settingBloc = SettingBloc(settingUseCase: DI.instance().getSettingUseCase())
    ..add(SettingGetEvent(
        SettingItem(isDark: false, pageStatus: PageStatus.initial, langCode: "en")));

  late SettingItem state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (BuildContext context) => _settingBloc,
      child: BlocBuilder<SettingBloc, SettingItem>(
        buildWhen: (previous, current) {
          return true;
        },
        bloc: _settingBloc,
        builder: (context, state) {
          this.state = state;
          return Container(
              color: getSelectedThemeColors(context).pageBackground,
              width: double.infinity,
              child: showPage(context));
        },
      ),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(Insets.lg),
              child: Text(
                Texts.settingPageTitle.translate,
                style:
                    TextStyles.h1Bold.copyWith(color: getSelectedThemeColors(context).primaryText),
              )),
          _rowTheme(state),
          SizedBox(
            height: Insets.lg,
          ),
          _rowLag(state),
        ],
      ),
    );
  }

  Widget _rowTheme(SettingItem settingItem) {
    return _getItemBackground(
        AppIcons.themeMode,
        Texts.themeTitle.translate,
        SwitchView(
          key: UniqueKey(),
          checkColor: getSelectedThemeColors(context).primaryColor,
          uncheckColor: getSelectedThemeColors(context).disableColor,
          onChanged: (value) {
            _settingBloc.add(SettingChangeEvent(settingItem.copyWith(isDark: value)));
          },
          value: settingItem.isDark,
        ));
  }

  Widget _rowLag(SettingItem settingItem) {
    var isRtl = isRTL(locale: Locale(settingItem.langCode));

    Widget child = Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isRtl
                  ? Colors.transparent
                  : getSelectedThemeColors(context).iconGreen.withOpacity(0.2),
              border: Border.fromBorderSide(BorderSide(
                  color: !isRtl ? Colors.transparent : getSelectedThemeColors(context).iconGreen))),
          child: InkWell(
            onTap: () {
              _settingBloc.add(SettingChangeEvent(settingItem.copyWith(langCode: "fa")));
            },
            child: ImageView(
              size: Insets.iconSizeL,
              src: AppIcons.langFa,
            ),
          ),
        ),
        SizedBox(
          width: Insets.sm,
        ),
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRtl
                  ? Colors.transparent
                  : getSelectedThemeColors(context).iconGreen.withOpacity(0.2),
              border: Border.fromBorderSide(BorderSide(
                  color: isRtl ? Colors.transparent : getSelectedThemeColors(context).iconGreen))),
          child: InkWell(
            onTap: () {
              _settingBloc.add(SettingChangeEvent(settingItem.copyWith(langCode: "en")));
            },
            child: ImageView(
              size: Insets.iconSizeL,
              src: AppIcons.langEn,
            ),
          ),
        )
      ],
    );
    return _getItemBackground(AppIcons.language, Texts.languageTitle.translate, child);
  }

  Container _getItemBackground(String icon, String title, Widget child) {
    return Container(
      height: Insets.buttonHeight,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
      decoration: BoxDecoration(
          color: getSelectedThemeColors(context).onBackground, boxShadow: Shadows.topAndBottom),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageView(
            size: Insets.d24,
            src: icon,
          ),
          SizedBox(
            width: Insets.xs,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyles.h2.copyWith(color: getSelectedThemeColors(context).secondaryText),
            ),
          ),
          child
        ],
      ),
    );
  }
}
