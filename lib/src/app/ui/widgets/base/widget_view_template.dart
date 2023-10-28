import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kardone/src/utils/device.dart';

abstract mixin class WidgetViewTemplate {
  late ScreenType screenType;

  Widget showPage(BuildContext context) {
    screenType = getFormFactor(context);
    return Material(
      color: Colors.transparent,
      child: switch (screenType) {
        ScreenType.desktop => desktopView(context),
        ScreenType.tablet => tabletView(context),
        ScreenType.handset => phoneView(context),
        ScreenType.watch => phoneView(context),
      },
    );
  }

  Widget phoneView(BuildContext context);

  Widget tabletView(BuildContext context) {
    return phoneView(context);
  }

  Widget desktopView(BuildContext context) {
    return tabletView(context);
  }
}
