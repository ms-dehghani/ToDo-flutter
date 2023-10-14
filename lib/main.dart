
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kardone/src/di/di.dart';
import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';
import 'package:kardone/src/model/items/tasks/priority/pojo/priority_item.dart';
import 'package:kardone/res/theme/themes.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/ui/pages/task/list/task_list_page.dart';
import 'package:kardone/src/utils/ht/html.dart';

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

  @override
  void initState() {
    HtmlFormatter.format();
    super.initState();
    _localeOverrideDelegate = SpecificLocalizationDelegate(Locale("fa"));
    applic.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = SpecificLocalizationDelegate(locale);
    });
  }

  Future<void> test() async {
    await DI.instance().provideDependencies();

    await DI.instance().getPriorityRepository().clear();

    await DI
        .instance()
        .getPriorityRepository()
        .createOrUpdatePriority(PriorityItem("1", "High", "#FF3B3B"));
    await DI
        .instance()
        .getPriorityRepository()
        .createOrUpdatePriority(PriorityItem("2", "Mid", "#FF8800"));
    await DI
        .instance()
        .getPriorityRepository()
        .createOrUpdatePriority(PriorityItem("3", "Low", "#06C270"));

    await DI.instance().providePriorityList();

    await DI
        .instance()
        .getCategoryRepository()
        .createOrUpdateCategory(CategoryItem("1", "cat title"));

    DI.instance().getTaskRepository().createOrUpdateTask(TaskItem(
        id: "id",
        title: "title",
        description: "description",
        categoryItem: CategoryItem("_id", "cat title"),
        priorityItem: PriorityItem("_id", "High", "#FF3B3B"),
        taskTimestamp: DateTime.now().millisecondsSinceEpoch));
    DI.instance().getTaskRepository().createOrUpdateTask(TaskItem(
        id: "id3",
        title: "title3",
        description: "description",
        priorityItem: PriorityItem("_id2", "Mid", "#FF8800"),
        taskTimestamp: DateTime.now().millisecondsSinceEpoch));
    DI.instance().getTaskRepository().createOrUpdateTask(TaskItem(
        id: "id4",
        title: "title4",
        description: "description",
        categoryItem: CategoryItem("_id", "cat title"),
        priorityItem: PriorityItem("_id3", "Low", "#06C270"),
        taskTimestamp: DateTime.now().millisecondsSinceEpoch));
    DI.instance().getTaskRepository().createOrUpdateTask(TaskItem(
        id: "id2",
        title: "title2",
        description: "description2",
        taskTimestamp: DateTime.now().add(Duration(days: 2)).millisecondsSinceEpoch));
    return Future.value();
    // var db = await openDatabase('my_db.db');
    // var pDB = PriorityItemDBDataProvider(db);
    // await pDB.createOrUpdatePriority(PriorityItem("_id", "High", "#FF3B3B"));
    // await pDB.createOrUpdatePriority(PriorityItem("_id2", "Mid", "#FF8800"));
    // await pDB.createOrUpdatePriority(PriorityItem("_id3", "Low", "#06C270"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      // home: TaskListPage(),
      localizationsDelegates: [
        _localeOverrideDelegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      locale: Locale("fa"),
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TaskListPage();
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              );
            }
          },
          future: test(),
        ),
      ),
    );
  }
}
