import 'package:get_it/get_it.dart';
import 'package:kardone/res/texts.dart';
import 'package:kardone/src/data/di/data_di.dart';
import 'package:kardone/src/domain/di/domain_di.dart';
import 'package:kardone/src/domain/models/priority/priority_item.dart';
import 'package:kardone/src/domain/usecase/category/category_usecase.dart';
import 'package:kardone/src/domain/usecase/priority/priority_usecase.dart';
import 'package:kardone/src/domain/usecase/task/task_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DI {
  static final DI _singleton = DI._internal();

  static DI instance() {
    return _singleton;
  }

  DI._internal();

  final getIt = GetIt.instance;

  Database? _database;

  late List<PriorityItem> prioritiesItem;

  Future<bool> provideDependencies() async {
    if (_database == null) {
      _database ??= await openDatabase('my_db.db');
      getIt.registerSingleton<Database>(_database!);

      var pref = await SharedPreferences.getInstance();
      getIt.registerSingleton<SharedPreferences>(pref);

      DataDI();
      DomainDI();

      await _providePriorityList();
    }
    return Future.value(true);
  }

  Future<bool> _providePriorityList() async {
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
    prioritiesItem = await getIt<PriorityUseCase>().getPriorities();
    return Future.value(true);
  }

  TaskUseCase getTaskUseCase() {
    return getIt<TaskUseCase>();
  }

  CategoryUseCase getCategoryUseCase() {
    return getIt<CategoryUseCase>();
  }

  PriorityUseCase getPriorityUseCase() {
    return getIt<PriorityUseCase>();
  }
}
