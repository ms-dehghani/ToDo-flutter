import 'package:get_it/get_it.dart';
import 'package:kardone/src/data/repositories/category/category_repository.dart';
import 'package:kardone/src/data/repositories/priority/priority_repository.dart';
import 'package:kardone/src/data/repositories/task/task_repository.dart';

import '../usecase/category/category_usecase.dart';
import '../usecase/priority/priority_usecase.dart';
import '../usecase/task/task_usecase.dart';

class DomainDI {
  final getIt = GetIt.instance;

  DomainDI() {
    getIt.registerSingleton<CategoryUseCase>(
        CategoryUseCase(repository: getIt<CategoryRepository>()));
    getIt.registerSingleton<PriorityUseCase>(
        PriorityUseCase(repository: getIt<PriorityRepository>()));

    getIt.registerSingleton<TaskUseCase>(TaskUseCase(repository: getIt<TaskRepository>()));
  }
}
