import 'package:ToDo/src/data/repositories/category/category_repository.dart';
import 'package:ToDo/src/data/repositories/priority/priority_repository.dart';
import 'package:ToDo/src/data/repositories/setting/setting_repository.dart';
import 'package:ToDo/src/data/repositories/task/task_repository.dart';
import 'package:ToDo/src/domain/usecase/category/clear/category_clear_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/createupdate/category_create_or_update_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/delete/category_delete_item_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/all/category_retrieve_all_items_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/item/category_retrieve_item_usecase.dart';
import 'package:ToDo/src/domain/usecase/setting/setting_usecase.dart';
import 'package:get_it/get_it.dart';

import '../usecase/priority/priority_usecase.dart';
import '../usecase/task/task_usecase.dart';

class DomainDI {
  final getIt = GetIt.instance;

  DomainDI() {
    _provideCategoryUseCases();

    getIt.registerSingleton<PriorityUseCase>(
        PriorityUseCase(repository: getIt<PriorityRepository>()));

    getIt.registerSingleton<TaskUseCase>(
        TaskUseCase(repository: getIt<TaskRepository>()));
    getIt.registerSingleton<SettingUseCase>(
        SettingUseCase(repository: getIt<SettingRepository>()));
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
}
