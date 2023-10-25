import 'package:kardone/res/texts.dart';
import 'package:kardone/src/data/datasource/category/category_data_provider.dart';
import 'package:kardone/src/data/datasource/priority/priority_data_provider.dart';
import 'package:kardone/src/data/datasource/task/db/task_item_db_data_provider.dart';
import 'package:kardone/src/data/datasource/task/task_data_provider.dart';
import 'package:kardone/src/data/datasource/category/db/category_item_db_data_provider.dart';
import 'package:kardone/src/data/repositories/category/category_repository.dart';
import 'package:kardone/src/data/datasource/priority/db/priority_item_db_data_provider.dart';
import 'package:kardone/src/domain/models/priority/priority_item.dart';
import 'package:kardone/src/data/repositories/priority/priority_repository.dart';
import 'package:kardone/src/data/repositories/task/task_repository.dart';
import 'package:kardone/src/domain/usecase/category/category_usecase.dart';
import 'package:kardone/src/domain/usecase/priority/priority_usecase.dart';
import 'package:kardone/src/domain/usecase/task/task_usecase.dart';
import 'package:sqflite/sqflite.dart';

class DI {
  static final DI _singleton = DI._internal();

  static DI instance() {
    return _singleton;
  }

  DI._internal();

  late final Database _database;

  late final PriorityUseCase _priorityUseCase;
  late final CategoryUseCase _categoryUseCase;
  late final TaskUseCase _taskUseCase;

  late List<PriorityItem> prioritiesItem;

  Future<bool> provideDependencies() async {
    _database = await openDatabase('my_db.db');

    _priorityUseCase = PriorityUseCase.init(PriorityRepository.init(_getLocalPriorityDB(), null));
    _categoryUseCase = CategoryUseCase.init(CategoryRepository.init(_getLocalCategoryDB(), null));
    _taskUseCase = TaskUseCase.init(TaskRepository.init(_getLocalTaskDB(), null));

    await providePriorityList();

    return Future.value(true);
  }

  Future<bool> providePriorityList() async {
    await DI
        .instance()
        .getPriorityUseCase()
        .createOrUpdatePriority(PriorityItem("1", Texts.priorityHigh, "#FF3B3B"));
    await DI
        .instance()
        .getPriorityUseCase()
        .createOrUpdatePriority(PriorityItem("2", Texts.priorityMed, "#FF8800"));
    await DI
        .instance()
        .getPriorityUseCase()
        .createOrUpdatePriority(PriorityItem("3", Texts.priorityLow, "#06C270"));
    prioritiesItem = await _priorityUseCase.getPriorities();
    return Future.value(true);
  }

  Database getDB() {
    return _database;
  }

  TaskDataProvider _getLocalTaskDB() {
    return TaskItemDBDataProvider(_database, _getLocalCategoryDB(), _getLocalPriorityDB());
  }

  CategoryDataProvider _getLocalCategoryDB() {
    return CategoryItemDBDataProvider(_database);
  }

  PriorityDataProvider _getLocalPriorityDB() {
    return PriorityItemDBDataProvider(_database);
  }

  TaskUseCase getTaskUseCase() {
    return _taskUseCase;
  }

  CategoryUseCase getCategoryUseCase() {
    return _categoryUseCase;
  }

  PriorityUseCase getPriorityUseCase() {
    return _priorityUseCase;
  }
}
