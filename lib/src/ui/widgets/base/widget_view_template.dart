import 'package:flutter/widgets.dart';
import 'package:kardone/src/utils/device.dart';

abstract mixin class WidgetViewTemplate {
  late ScreenType screenType;

  Widget showPage(BuildContext context) {
    screenType = getFormFactor(context);
    return switch (screenType) {
      ScreenType.desktop => desktopView(),
      ScreenType.tablet => tabletView(),
      ScreenType.handset => phoneView(),
      ScreenType.watch => phoneView(),
    };
  }

  Widget phoneView();

  Widget tabletView() {
    return phoneView();
  }

  Widget desktopView() {
    return tabletView();
  }
}
