import 'package:kardone/res/texts.dart';
import 'package:kardone/src/model/items/tasks/category/data_provider/category_item_data_provider_impl.dart';
import 'package:kardone/src/model/items/tasks/category/data_provider/db/category_item_db_data_provider.dart';
import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';
import 'package:kardone/src/model/items/tasks/category/repo/category_repository.dart';
import 'package:kardone/src/model/items/tasks/priority/data_provider/db/priority_item_db_data_provider.dart';
import 'package:kardone/src/model/items/tasks/priority/data_provider/priority_item_data_provider_impl.dart';
import 'package:kardone/src/model/items/tasks/priority/pojo/priority_item.dart';
import 'package:kardone/src/model/items/tasks/priority/repo/priority_repository.dart';
import 'package:kardone/src/model/items/tasks/task/data_provider/db/task_item_db_data_provider.dart';
import 'package:kardone/src/model/items/tasks/task/data_provider/task_item_data_provider_impl.dart';
import 'package:kardone/src/model/items/tasks/task/repo/task_repository.dart';
import 'package:sqflite/sqflite.dart';

class DI {
  static final DI _singleton = DI._internal();

  static DI instance() {
    return _singleton;
  }

  DI._internal();

  late final Database _database;

  late final TaskRepository _taskRepository;
  late final CategoryRepository _categoryRepository;
  late final PriorityRepository _priorityRepository;

  late List<PriorityItem> prioritiesItem;

  Future<bool> provideDependencies() async {
    _database = await openDatabase('my_db.db');

    _categoryRepository = CategoryRepository.init(_getLocalCategoryDB(), null);
    _priorityRepository = PriorityRepository.init(_getLocalPriorityDB(), null);
    _taskRepository = TaskRepository.init(_getLocalTaskDB(), null);

    await providePriorityList();

    return Future.value(true);
  }

  Future<bool> providePriorityList() async {
    await DI
        .instance()
        .getPriorityRepository()
        .createOrUpdatePriority(PriorityItem("1", Texts.priorityHigh, "#FF3B3B"));
    await DI
        .instance()
        .getPriorityRepository()
        .createOrUpdatePriority(PriorityItem("2", Texts.priorityMed, "#FF8800"));
    await DI
        .instance()
        .getPriorityRepository()
        .createOrUpdatePriority(PriorityItem("3", Texts.priorityLow, "#06C270"));
    prioritiesItem = await _priorityRepository.getPriorities();
    return Future.value(true);
  }

  Database getDB() {
    return _database;
  }

  TaskItemDataProviderImpl _getLocalTaskDB() {
    return TaskItemDBDataProvider(_database, _categoryRepository, _priorityRepository);
  }

  CategoryItemDataProviderImpl _getLocalCategoryDB() {
    return CategoryItemDBDataProvider(_database);
  }

  PriorityItemDataProviderImpl _getLocalPriorityDB() {
    return PriorityItemDBDataProvider(_database);
  }

  TaskRepository getTaskRepository() {
    return _taskRepository;
  }

  CategoryRepository getCategoryRepository() {
    return _categoryRepository;
  }

  PriorityRepository getPriorityRepository() {
    return _priorityRepository;
  }
}
