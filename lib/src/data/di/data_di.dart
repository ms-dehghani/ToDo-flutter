import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import '../datasource/category/db/category_item_db_data_provider.dart';
import '../datasource/priority/db/priority_item_db_data_provider.dart';
import '../datasource/task/db/task_item_db_data_provider.dart';
import '../repositories/category/category_repository.dart';
import '../repositories/priority/priority_repository.dart';
import '../repositories/task/task_repository.dart';

class DataDI {
  final getIt = GetIt.instance;

  DataDI() {
    _priorityRepository();
    _categoryRepository();
    _taskRepository();
  }

  void _priorityRepository() {
    var database = getIt<Database>();
    var priorityDataProvider = PriorityItemDBDataProvider(database);

    getIt.registerSingleton<PriorityItemDBDataProvider>(priorityDataProvider);
    getIt.registerSingleton<PriorityRepository>(PriorityRepository(priorityDataProvider, null));
  }

  void _categoryRepository() {
    var database = getIt<Database>();
    var categoryDataProvider = CategoryItemDBDataProvider(database);

    getIt.registerSingleton<CategoryItemDBDataProvider>(categoryDataProvider);
    getIt.registerSingleton<CategoryRepository>(CategoryRepository(categoryDataProvider, null));
  }

  void _taskRepository() {
    var database = getIt<Database>();
    var taskDataProvider = TaskItemDBDataProvider(
        database, getIt<CategoryItemDBDataProvider>(), getIt<PriorityItemDBDataProvider>());

    getIt.registerSingleton<TaskItemDBDataProvider>(taskDataProvider);

    getIt.registerSingleton<TaskRepository>(TaskRepository(taskDataProvider, null));
  }
}
