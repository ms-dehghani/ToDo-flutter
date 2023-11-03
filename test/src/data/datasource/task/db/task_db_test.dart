import 'package:faker/faker.dart';
import 'package:ToDo/src/data/datasource/category/db/category_item_db_data_provider.dart';
import 'package:ToDo/src/data/datasource/priority/db/priority_item_db_data_provider.dart';
import 'package:ToDo/src/data/datasource/task/db/task_item_db_data_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

import '../../../../../fake_items.dart';


void main() {
  late TaskItemDBDataProvider dataProvider;
  late CategoryItemDBDataProvider categoryDataProvider;
  late PriorityItemDBDataProvider priorityDataProvider;
  late Faker faker;

  setUpAll(() async {
    faker = Faker();
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    categoryDataProvider = CategoryItemDBDataProvider(db);
    priorityDataProvider = PriorityItemDBDataProvider(db);
    dataProvider = TaskItemDBDataProvider(db, categoryDataProvider, priorityDataProvider);
  });

  tearDown(() {
    dataProvider.clear();
    priorityDataProvider.clear();
    categoryDataProvider.clear();
  });

  test('Insert Item', () async {
    var item = getFakeTaskItem();
    await dataProvider.createOrUpdateTask(item);

    var retrieveItem = await dataProvider.getTaskByID(item.ID);

    expect(retrieveItem, isNotNull);

    expect(retrieveItem!.ID, item.ID);
    expect(retrieveItem.title, item.title);
    expect(retrieveItem.isDone, item.isDone);
    expect(retrieveItem.taskTimestamp, item.taskTimestamp);
    expect(retrieveItem.description, item.description);
    expect(retrieveItem.categoryItem!.ID, item.categoryItem!.ID);
    expect(retrieveItem.priorityItem!.ID, item.priorityItem!.ID);
  });

  test('Multiple insert Item', () async {
    var item = getFakeTaskItem();
    var item2 = item.copyWith(taskId: faker.lorem.sentence());
    var item3 = item.copyWith(taskId: faker.lorem.sentence());

    await dataProvider.createOrUpdateTask(item);
    await dataProvider.createOrUpdateTask(item2);
    await dataProvider.createOrUpdateTask(item3);

    var retrieveItem = await dataProvider.getAllTasks();

    expect(retrieveItem, isNotEmpty);

    expect(retrieveItem.length, 3);
  });

  test('Update Task', () async {
    var item = getFakeTaskItem();

    await dataProvider.createOrUpdateTask(item);
    item.title = "new title";
    await dataProvider.createOrUpdateTask(item);

    var retrieveItem = await dataProvider.getTaskByID(item.ID);

    expect(retrieveItem!.ID, item.ID);
    expect(retrieveItem.title, item.title);
    expect(retrieveItem.isDone, item.isDone);
    expect(retrieveItem.taskTimestamp, item.taskTimestamp);
    expect(retrieveItem.description, item.description);
  });

  test('Update Category Item', () async {
    var item = getFakeTaskItem();
    var catItem = getFakeCategoryItem();

    await dataProvider.createOrUpdateTask(item);
    item.categoryItem = catItem;
    await dataProvider.createOrUpdateTask(item);

    var retrieveItem = await dataProvider.getTaskByID(item.ID);

    expect(retrieveItem!.categoryItem!.ID, item.categoryItem!.ID);
  });

  test('Update Priority Item', () async {
    var item = getFakeTaskItem();
    var priorityItem = getFakePriorityItem();

    await dataProvider.createOrUpdateTask(item);
    item.priorityItem = priorityItem;
    await dataProvider.createOrUpdateTask(item);

    var retrieveItem = await dataProvider.getTaskByID(item.ID);

    expect(retrieveItem!.priorityItem!.ID, item.priorityItem!.ID);
  });

  test('Get Task In Same Day', () async {
    var item = getFakeTaskItem().copyWith(taskTimestamp: DateTime.now().millisecondsSinceEpoch);
    var item2 = getFakeTaskItem().copyWith(
        taskTimestamp: DateTime.fromMillisecondsSinceEpoch(item.taskTimestamp)
            .copyWith(hour: 23, minute: 59, second: 59)
            .millisecondsSinceEpoch);
    var item3 = getFakeTaskItem().copyWith(
        taskTimestamp: DateTime.fromMillisecondsSinceEpoch(item.taskTimestamp)
            .copyWith(hour: 0, minute: 0, second: 1)
            .millisecondsSinceEpoch);
    var item4 = getFakeTaskItem().copyWith(
        taskTimestamp: DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch);
    var item5 = getFakeTaskItem().copyWith(
        taskTimestamp: DateTime.now().add(const Duration(days: 2)).millisecondsSinceEpoch);

    await dataProvider.createOrUpdateTask(item);
    await dataProvider.createOrUpdateTask(item2);
    await dataProvider.createOrUpdateTask(item3);
    await dataProvider.createOrUpdateTask(item4);
    await dataProvider.createOrUpdateTask(item5);

    var todayList = await dataProvider.getTaskListFromData(DateTime.now().millisecondsSinceEpoch);
    expect(todayList.length, 3);

    todayList = await dataProvider
        .getTaskListFromData(DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch);
    expect(todayList.length, 1);

    todayList = await dataProvider
        .getTaskListFromData(DateTime.now().add(const Duration(days: 2)).millisecondsSinceEpoch);
    expect(todayList.length, 1);

    todayList = await dataProvider
        .getTaskListFromData(DateTime.now().add(const Duration(days: 3)).millisecondsSinceEpoch);
    expect(todayList.length, 0);
  });

  test('Get Incorrect Item From ID', () async {
    var item = getFakeTaskItem();
    await dataProvider.createOrUpdateTask(item);
    var retrieveItem = await dataProvider.getTaskByID("sss");

    expect(retrieveItem, isNull);
  });

  test('Delete Item And Get Task Whit ID', () async {
    var item = getFakeTaskItem();
    await dataProvider.createOrUpdateTask(item);
    await dataProvider.deleteTask(item.ID);
    var retrieveItem = await dataProvider.getTaskByID(item.ID);

    expect(retrieveItem, isNull);
  });

  test('Delete Item And Get Day Tasks', () async {
    var item = getFakeTaskItem();
    await dataProvider.createOrUpdateTask(item);
    await dataProvider.deleteTask(item.ID);
    var retrieveItem = await dataProvider.getTaskListFromData(item.taskTimestamp);

    expect(retrieveItem, isEmpty);
  });

  test('Clear', () async {
    await dataProvider.createOrUpdateTask(getFakeTaskItem());
    await dataProvider.createOrUpdateTask(getFakeTaskItem());
    await dataProvider.createOrUpdateTask(getFakeTaskItem());
    await dataProvider.createOrUpdateTask(getFakeTaskItem());
    await dataProvider.createOrUpdateTask(getFakeTaskItem());
    await dataProvider.createOrUpdateTask(getFakeTaskItem());
    await dataProvider.clear();
    var retrieveItem = await dataProvider.getAllTasks();

    expect(retrieveItem, isEmpty);
  });
}
