import 'package:ToDo/applic.dart';
import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/res/texts.dart';
import 'package:ToDo/src/app/ui/widgets/image/image_view.dart';
import 'package:ToDo/src/utils/direction_util.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/base/widget_view_template.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with WidgetViewTemplate {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: getSelectedThemeColors().pageBackground,
        width: double.infinity,
        child: showPage(context));
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
                style: TextStyles.h1Bold,
              )),
          _rowTheme(),
          SizedBox(
            height: Insets.lg,
          ),
          _rowLag(),
        ],
      ),
    );
  }

  Widget _rowTheme() {
    return _getItemBackground(AppIcons.themeMode, Texts.themeTitle.translate, Container());
  }

  Widget _rowLag() {
    Widget child = Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isRTL()
                  ? Colors.transparent
                  : getSelectedThemeColors().iconGreen.withOpacity(0.2),
              border: Border.fromBorderSide(BorderSide(
                  color: !isRTL() ? Colors.transparent : getSelectedThemeColors().iconGreen))),
          child: InkWell(
            onTap: () {
              setState(() {
                APPLIC.changeLang("fa");
              });
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
              color: isRTL()
                  ? Colors.transparent
                  : getSelectedThemeColors().iconGreen.withOpacity(0.2),
              border: Border.fromBorderSide(BorderSide(
                  color: isRTL() ? Colors.transparent : getSelectedThemeColors().iconGreen))),
          child: InkWell(
            onTap: () {
              setState(() {
                APPLIC.changeLang("en");
              });
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
          color: getSelectedThemeColors().onBackground, boxShadow: Shadows.topAndBottom),
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
              style: TextStyles.h2.copyWith(color: getSelectedThemeColors().secondaryText),
            ),
          ),
          child
        ],
      ),
    );
  }
}
