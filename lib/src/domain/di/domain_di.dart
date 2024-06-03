import 'package:ToDo/src/data/repositories/category/category_repository.dart';
import 'package:ToDo/src/data/repositories/priority/priority_repository.dart';
import 'package:ToDo/src/data/repositories/setting/setting_repository.dart';
import 'package:ToDo/src/data/repositories/task/task_repository.dart';
import 'package:ToDo/src/domain/usecase/category/clear/category_clear_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/createupdate/category_create_or_update_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/delete/category_delete_item_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/all/category_retrieve_all_items_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/item/category_retrieve_item_usecase.dart';
import 'package:ToDo/src/domain/usecase/priority/create/priority_create_usecase.dart';
import 'package:ToDo/src/domain/usecase/priority/retrieve/priority_retrieve_all_items_usecase.dart';
import 'package:ToDo/src/domain/usecase/setting/createupdate/setting_create_update_usecase.dart';
import 'package:ToDo/src/domain/usecase/setting/retrieve/setting_retrieve_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/createupdate/task_create_update_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/delete/task_delete_item_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/existence/task_check_existence_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/retrieve/daylist/task_retrieve_day_list_items_usecase.dart';
import 'package:get_it/get_it.dart';

class DomainDI {
  final getIt = GetIt.instance;

  DomainDI() {
    _provideCategoryUseCases();
    _providePriorityUseCases();
    _provideTaskUseCases();
    _provideSettingUseCases();
  }

  void _provideCategoryUseCases() {
    getIt.registerSingleton<CategoryClearUseCase>(
        CategoryClearUseCase(repository: getIt<CategoryRepository>()));
    getIt.registerSingleton<CategoryCreateOrUpdateUseCase>(
        CategoryCreateOrUpdateUseCase(repository: getIt<CategoryRepository>()));
    getIt.registerSingleton<CategoryDeleteUseCase>(
        CategoryDeleteUseCase(repository: getIt<CategoryRepository>()));
    getIt.registerSingleton<CategoryRetrieveAllItemsUseCase>(
        CategoryRetrieveAllItemsUseCase(
            repository: getIt<CategoryRepository>()));
    getIt.registerSingleton<CategoryRetrieveItemUseCase>(
        CategoryRetrieveItemUseCase(repository: getIt<CategoryRepository>()));
  }

  void _providePriorityUseCases() {
    getIt.registerSingleton<PriorityCreateUseCase>(
        PriorityCreateUseCase(repository: getIt<PriorityRepository>()));
    getIt.registerSingleton<PriorityRetrieveAllItemsUseCase>(
        PriorityRetrieveAllItemsUseCase(
            repository: getIt<PriorityRepository>()));
  }

  void _provideTaskUseCases() {
    getIt.registerSingleton<SettingCreateUpdateUseCase>(
        SettingCreateUpdateUseCase(repository: getIt<SettingRepository>()));
    getIt.registerSingleton<SettingRetrieveUseCase>(
        SettingRetrieveUseCase(repository: getIt<SettingRepository>()));
  }

  void _provideSettingUseCases() {
    getIt.registerSingleton<TaskCreateUpdateUseCase>(
        TaskCreateUpdateUseCase(repository: getIt<TaskRepository>()));
    getIt.registerSingleton<TaskDeleteItemUseCase>(
        TaskDeleteItemUseCase(repository: getIt<TaskRepository>()));
    getIt.registerSingleton<TaskRetrieveDayListItemsUseCase>(
        TaskRetrieveDayListItemsUseCase(repository: getIt<TaskRepository>()));
    getIt.registerSingleton<TaskCheckExistenceUseCase>(
        TaskCheckExistenceUseCase(repository: getIt<TaskRepository>()));
  }
}
