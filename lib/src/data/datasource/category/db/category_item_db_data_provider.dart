import 'package:ToDo/src/base/base_model.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/models/category/category_static.dart';
import 'package:sqflite/sqflite.dart';

import '../category_data_provider.dart';

class CategoryItemDBDataProvider extends BaseModel implements CategoryDataProvider {
  final Database _database;

  final String tableName = "Category";

  static CategoryItemDBDataProvider? _singleton;

  factory CategoryItemDBDataProvider(Database database) {
    _singleton ??= CategoryItemDBDataProvider._internal(database);
    return _singleton!;
  }

  CategoryItemDBDataProvider._internal(this._database) {
    _database.execute("create table if not exists $tableName ($filedId TEXT PRIMARY KEY,"
        "$filedTitle TEXT, $filedDescription TEXT, $filedParentID TEXT)");
  }

  @override
  Future<CategoryItem> createOrUpdateCategory(CategoryItem categoryItem) async {
    if (categoryItem.ID.isEmpty) categoryItem.ID = DateTime.now().millisecondsSinceEpoch.toString();

    int id = await _database.insert(tableName, categoryItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (categoryItem.ID.isEmpty) categoryItem.ID = id.toString();
    return categoryItem;
  }

  @override
  Future<List<CategoryItem>> getCategories() async {
    List<CategoryItem> result = [];
    List<Map> list = await _database.query(tableName,
        columns: CategoryItem.empty().toMap().keys.toList(),
        orderBy: "$filedId DESC",
        distinct: true);
    for (var items in list) {
      var item = CategoryItem.fromMap(items);
      if (item.ID.isNotEmpty) {
        result.add(item);
      }
    }

    var catItem = CategoryItem.empty();
    catItem.ID = "0";
    catItem.title = "noCat";
    if (result.where((element) => element.ID == "0").isEmpty) result.add(catItem);
    return result;
  }

  @override
  Future<CategoryItem?> getCategory(String categoryID) async {
    List<Map> list = await _database.query(tableName,
        columns: CategoryItem.empty().toMap().keys.toList(),
        where: "$filedId = ?",
        whereArgs: [categoryID],
        limit: 1);
    return list.isEmpty ? null : CategoryItem.fromMap(list[0]);
  }

  @override
  Future<bool> deleteCategory(String categoryID) async {
    int result = await _database.delete(tableName, where: "$filedId = ?", whereArgs: [categoryID]);
    return result > 0;
  }

  @override
  Future<void> clear() async {
    await _database.delete(tableName);
  }
}
