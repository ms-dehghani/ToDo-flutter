import 'package:ToDo/res/string/texts.dart';
import 'package:ToDo/res/styles/theme/themes.dart';
import 'package:ToDo/src/app/di/di.dart';
import 'package:ToDo/src/app/ui/pages/splash/splash_screen.dart';
import 'package:ToDo/src/base/navigation_service.dart';
import 'package:ToDo/src/domain/models/setting/setting_item.dart';
import 'package:ToDo/src/utils/direction_util.dart';
import 'package:ToDo/src/utils/ht/html.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'applic.dart';
import 'translations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SpecificLocalizationDelegate _localeOverrideDelegate;

  SettingItem? setting;

  @override
  void initState() {
    HtmlFormatter.format();
    super.initState();
    _localeOverrideDelegate = const SpecificLocalizationDelegate(Locale("en"));
    applic.onLocaleChanged = onLocaleChange;
    applic.onThemeChanged = onThemeChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = SpecificLocalizationDelegate(locale);
    });
  }

  onThemeChange(bool isDark) {
    if (isDark && _themeMode == ThemeMode.dark) return;
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> initDI() async {
    if (setting == null) {
      await DI.instance().provideDependencies();
      setting = await DI.instance().getSettingRetrieveUseCase().invoke();
      APPLIC.changeLang(setting!.langCode);
      APPLIC.changeTheme(setting!.isDark);
    }
    return Future.value();
  }

  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: Texts.appName,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        _localeOverrideDelegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      locale: _localeOverrideDelegate.overriddenLocale,
      home: Directionality(
        textDirection: getDirection(),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SplashScreen();
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              );
            }
          },
          future: initDI(),
        ),
      ),
    );
  }
}
