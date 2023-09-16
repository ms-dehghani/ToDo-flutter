import 'package:flutter/material.dart';
import 'package:kardone/model/items/priority/data_provider/db/priority_item_db_data_provider.dart';
import 'package:kardone/model/items/priority/pojo/priority_item.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  void test() async {
    var db = await openDatabase('my_db.db');
    var pDB = PriorityItemDBDataProvider(db);
    await pDB.createOrUpdatePriority(PriorityItem("_id", "_title", "_color"));
    await pDB.createOrUpdatePriority(PriorityItem("_id2", "_title2", "_color3"));
    await pDB.createOrUpdatePriority(PriorityItem("_id3", "_title3", "_color3"));

    await pDB.getPriority("_id");
    await pDB.getPriorities();
    await pDB.deletePriority("_id2");
  }

  @override
  Widget build(BuildContext context) {
    test();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ).copyWith(),
      home: Container(),
    );
  }
}
