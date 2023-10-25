import 'package:get_it/get_it.dart';
import 'package:kardone/src/data/repositories/setting/setting_repository.dart';

import '../datasource/category/db/category_item_db_data_provider.dart';
import '../datasource/priority/db/priority_item_db_data_provider.dart';
import '../datasource/setting/pref/setting_item_data_provider.dart';
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
    _settingRepository();
  }

  void _priorityRepository() {
    var priorityDataProvider = PriorityItemDBDataProvider(getIt());

    getIt.registerSingleton<PriorityItemDBDataProvider>(priorityDataProvider);
    getIt.registerSingleton<PriorityRepository>(PriorityRepository(priorityDataProvider, null));
  }

  void _categoryRepository() {
    var categoryDataProvider = CategoryItemDBDataProvider(getIt());

    getIt.registerSingleton<CategoryItemDBDataProvider>(categoryDataProvider);
    getIt.registerSingleton<CategoryRepository>(CategoryRepository(categoryDataProvider, null));
  }

  void _taskRepository() {
    var taskDataProvider = TaskItemDBDataProvider(
        getIt(), getIt<CategoryItemDBDataProvider>(), getIt<PriorityItemDBDataProvider>());

    getIt.registerSingleton<TaskItemDBDataProvider>(taskDataProvider);

    getIt.registerSingleton<TaskRepository>(TaskRepository(taskDataProvider, null));
  }

  void _settingRepository() {
    getIt.registerSingleton<SettingItemDataProvider>(SettingItemDataProvider(getIt()));
    getIt.registerSingleton<SettingRepository>(SettingRepository(getIt<SettingItemDataProvider>()));
  }
}
