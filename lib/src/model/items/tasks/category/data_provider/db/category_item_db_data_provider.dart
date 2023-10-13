import 'package:kardone/arch/base_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../pojo/category_item.dart';
import '../../pojo/category_static.dart';
import '../category_item_data_provider_impl.dart';

class CategoryItemDBDataProvider extends BaseModel implements CategoryItemDataProviderImpl {
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
    List<Map> list = await _database.query(
      tableName,
      columns: CategoryItem.empty().toMap().keys.toList(),
      orderBy: "$filedId DESC",
    );
    for (var items in list) {
      print(items);
      result.add(CategoryItem.fromMap(items));
    }
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
