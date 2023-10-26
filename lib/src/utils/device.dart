import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;
}

enum ScreenType { desktop, tablet, handset, watch }

ScreenType getFormFactor(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > FormFactor.desktop) return ScreenType.desktop;
  if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
  if (deviceWidth > FormFactor.handset) return ScreenType.handset;
  return ScreenType.watch;
}

enum ScreenSize { small, normal, large, extraLarge }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > FormFactor.desktop) return ScreenSize.extraLarge;
  if (deviceWidth > FormFactor.tablet) return ScreenSize.large;
  if (deviceWidth > FormFactor.handset) return ScreenSize.normal;
  return ScreenSize.small;
}

bool isHandset(BuildContext context) {
  return MediaQuery.of(context).size.width < FormFactor.tablet;
}

bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);

bool get isDesktopDevice => !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;

bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

double getHeight(BuildContext context) => MediaQuery.of(context).size.height;
