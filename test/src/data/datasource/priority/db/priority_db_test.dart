import 'package:faker/faker.dart';
import 'package:kardone/src/data/datasource/priority/db/priority_item_db_data_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

import '../../../../../fake_items.dart';


void main() {
  late PriorityItemDBDataProvider dataProvider;
  late Faker faker;

  setUpAll(() async {
    faker = Faker();
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    dataProvider = PriorityItemDBDataProvider(db);
  });

  tearDown(() {
    dataProvider.clear();
  });

  test('Insert Item', () async {
    var item = getFakePriorityItem();

    await dataProvider.createOrUpdatePriority(item);
    var retrieveItem = await dataProvider.getPriority(item.ID);

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.ID, item.ID);
    expect(retrieveItem.title, item.title);
    expect(retrieveItem.color, item.color);
    expect(retrieveItem.description, item.description);
  });

  test('Multiple insert Item', () async {
    var item = getFakePriorityItem();
    var item2 = item.copyWith(id: faker.lorem.sentence());
    var item3 = item.copyWith(id: faker.lorem.sentence());

    await dataProvider.createOrUpdatePriority(item);
    await dataProvider.createOrUpdatePriority(item2);
    await dataProvider.createOrUpdatePriority(item3);

    var retrieveItem = await dataProvider.getPriorities();

    expect(retrieveItem, isNotEmpty);
    expect(retrieveItem.length, 3);
  });

  test('Update Item', () async {
    var item = getFakePriorityItem();

    await dataProvider.createOrUpdatePriority(item);
    item.title = "new title";
    await dataProvider.createOrUpdatePriority(item);
    var retrieveItem = await dataProvider.getPriority(item.ID);

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.ID, item.ID);
    expect(retrieveItem.title, item.title);
    expect(retrieveItem.color, item.color);
    expect(retrieveItem.description, item.description);
  });

  test('Get Correct Item', () async {
    var item = getFakePriorityItem();
    var item2 = item.copyWith(id: faker.lorem.sentence());
    var item3 = item.copyWith(id: faker.lorem.sentence());

    await dataProvider.createOrUpdatePriority(item);
    await dataProvider.createOrUpdatePriority(item2);
    await dataProvider.createOrUpdatePriority(item3);
    var retrieveItem = await dataProvider.getPriority(item2.ID);

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.ID, item2.ID);
    expect(retrieveItem.title, item2.title);
    expect(retrieveItem.color, item.color);
    expect(retrieveItem.description, item2.description);
  });

  test('Get Incorrect Item', () async {
    var item = getFakePriorityItem();

    await dataProvider.createOrUpdatePriority(item);
    var retrieveItem = await dataProvider.getPriority("sss");

    expect(retrieveItem, isNull);
  });

  test('Delete Item', () async {
    var item = getFakePriorityItem();

    await dataProvider.createOrUpdatePriority(item);
    await dataProvider.deletePriority(item.ID);
    var retrieveItem = await dataProvider.getPriority(item.ID);

    expect(retrieveItem, isNull);
  });

  test('Clear', () async {
    await dataProvider.createOrUpdatePriority(getFakePriorityItem());
    await dataProvider.createOrUpdatePriority(getFakePriorityItem());
    await dataProvider.createOrUpdatePriority(getFakePriorityItem());
    await dataProvider.createOrUpdatePriority(getFakePriorityItem());
    await dataProvider.createOrUpdatePriority(getFakePriorityItem());
    await dataProvider.clear();
    var retrieveItem = await dataProvider.getPriorities();

    expect(retrieveItem, isEmpty);
  });

}
