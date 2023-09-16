import 'package:kardone/arch/base_model.dart';
import 'package:kardone/model/items/priority/pojo/priority_item.dart';
import 'package:sqflite/sqflite.dart';

import '../../pojo/priority_static.dart';
import '../priority_item_data_provider_impl.dart';

class PriorityItemDBDataProvider extends BaseModel implements PriorityItemDataProviderImpl {
  Database _database;

  final String tableName = "Priority";

  PriorityItemDBDataProvider(this._database) {
    _database.execute("create table if not exists $tableName ($filedId TEXT PRIMARY KEY,"
        "$filedTitle TEXT, $filedDescription TEXT, $filedColor TEXT)");
  }

  @override
  Future<PriorityItem> createOrUpdatePriority(PriorityItem priorityItem) async {
    int id = await _database.insert(tableName, priorityItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (priorityItem.ID.isEmpty) priorityItem.ID = id.toString();
    return priorityItem;
  }

  @override
  Future<bool> deletePriority(String priorityID) async {
    int result = await _database.delete(tableName, where: "$filedId = ?", whereArgs: [priorityID]);
    return result > 0;
  }

  @override
  Future<List<PriorityItem>> getPriorities() async {
    List<PriorityItem> result = [];
    List<Map> list = await _database.query(
      tableName,
      columns: PriorityItem.empty().toMap().keys.toList(),
    );
    for (var items in list) {
      result.add(PriorityItem.fromMap(items));
    }
    return result;
  }

  @override
  Future<PriorityItem?> getPriority(String priorityID) async {
    List<Map> list = await _database.query(tableName,
        columns: PriorityItem.empty().toMap().keys.toList(),
        where: "$filedId = ?",
        whereArgs: [priorityID],
        limit: 1);
    return list.isEmpty ? null : PriorityItem.fromMap(list[0]);
  }
}
