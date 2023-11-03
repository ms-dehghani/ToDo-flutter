import 'package:faker/faker.dart';
import 'package:ToDo/src/data/datasource/category/db/category_item_db_data_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

import '../../../../../fake_items.dart';

void main() {
  late CategoryItemDBDataProvider dataProvider;
  late Faker faker;

  setUpAll(() async {
    faker = Faker();
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    dataProvider = CategoryItemDBDataProvider(db);
  });

  tearDown(() {
    dataProvider.clear();
  });

  test('Insert Item', () async {
    var item = getFakeCategoryItem();

    await dataProvider.createOrUpdateCategory(item);
    var retrieveItem = await dataProvider.getCategory(item.ID);

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.ID, item.ID);
    expect(retrieveItem.title, item.title);
    expect(retrieveItem.description, item.description);
  });

  test('Multiple insert Item', () async {
    await dataProvider.clear();

    var item = getFakeCategoryItem();
    var item2 = item.copyWith(id: faker.lorem.sentence());
    var item3 = item.copyWith(id: faker.lorem.sentence());
    var item4 = item.copyWith(id: faker.lorem.sentence());
    var item5 = item.copyWith(id: faker.lorem.sentence());

    await dataProvider.createOrUpdateCategory(item);
    await dataProvider.createOrUpdateCategory(item2);
    await dataProvider.createOrUpdateCategory(item3);
    await dataProvider.createOrUpdateCategory(item4);
    await dataProvider.createOrUpdateCategory(item5);

    var retrieveItem = await dataProvider.getCategories();

    expect(retrieveItem, isNotEmpty);
    //// added no cat to end of list
    expect(retrieveItem.length, 6);
  });

  test('Update Item', () async {
    var item = getFakeCategoryItem();

    await dataProvider.createOrUpdateCategory(item);
    item.title = "new title";
    await dataProvider.createOrUpdateCategory(item);

    var retrieveItem = await dataProvider.getCategory(item.ID);

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.ID, item.ID);
    expect(retrieveItem.title, item.title);
    expect(retrieveItem.description, item.description);
  });

  test('Get Correct Item', () async {
    var item = getFakeCategoryItem();
    var item2 = item.copyWith(id: faker.lorem.sentence());
    var item3 = item.copyWith(id: faker.lorem.sentence());

    await dataProvider.createOrUpdateCategory(item);
    await dataProvider.createOrUpdateCategory(item2);
    await dataProvider.createOrUpdateCategory(item3);

    var retrieveItem = await dataProvider.getCategory(item2.ID);

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.ID, item2.ID);
    expect(retrieveItem.title, item2.title);
    expect(retrieveItem.description, item2.description);
  });

  test('Get Incorrect Item', () async {
    var item = getFakeCategoryItem();

    await dataProvider.createOrUpdateCategory(item);
    var retrieveItem = await dataProvider.getCategory("sss");

    expect(retrieveItem, isNull);
  });

  test('Delete Item', () async {
    var item = getFakeCategoryItem();

    await dataProvider.createOrUpdateCategory(item);
    await dataProvider.deleteCategory(item.ID);
    var retrieveItem = await dataProvider.getCategory(item.ID);

    expect(retrieveItem, isNull);
  });

  test('Clear', () async {
    await dataProvider.createOrUpdateCategory(getFakeCategoryItem());
    await dataProvider.createOrUpdateCategory(getFakeCategoryItem());
    await dataProvider.createOrUpdateCategory(getFakeCategoryItem());
    await dataProvider.createOrUpdateCategory(getFakeCategoryItem());
    await dataProvider.createOrUpdateCategory(getFakeCategoryItem());

    await dataProvider.clear();

    var retrieveItem = await dataProvider.getCategories();

    //// added no cat to end of list

    expect(retrieveItem.length, 1);
  });
}
