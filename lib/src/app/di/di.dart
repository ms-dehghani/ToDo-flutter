import 'package:ToDo/res/texts.dart';
import 'package:ToDo/src/data/di/data_di.dart';
import 'package:ToDo/src/domain/di/domain_di.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/usecase/category/createupdate/category_create_or_update_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/delete/category_delete_item_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/all/category_retrieve_all_items_usecase.dart';
import 'package:ToDo/src/domain/usecase/priority/create/priority_create_usecase.dart';
import 'package:ToDo/src/domain/usecase/priority/retrieve/priority_retrieve_all_items_usecase.dart';
import 'package:ToDo/src/domain/usecase/setting/createupdate/setting_create_update_usecase.dart';
import 'package:ToDo/src/domain/usecase/setting/retrieve/setting_retrieve_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/createupdate/task_create_update_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/delete/task_delete_item_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/existence/task_check_existence_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/retrieve/daylist/task_retrieve_day_list_items_usecase.dart';
import 'package:get_it/get_it.dart';
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
        .getPriorityCreateUseCase()
        .invoke(PriorityItem("1", Texts.priorityHigh, "#FF3B3B"));
    await DI
        .instance()
        .getPriorityCreateUseCase()
        .invoke(PriorityItem("2", Texts.priorityMid, "#FF8800"));
    await DI
        .instance()
        .getPriorityCreateUseCase()
        .invoke(PriorityItem("3", Texts.priorityLow, "#06C270"));
    prioritiesItem = await getIt<PriorityRetrieveAllItemsUseCase>().invoke();
    return Future.value(true);
  }

  TaskCheckExistenceUseCase getTaskCheckExistenceUseCase() {
    return getIt<TaskCheckExistenceUseCase>();
  }

  TaskRetrieveDayListItemsUseCase getTaskRetrieveDayListItemsUseCase() {
    return getIt<TaskRetrieveDayListItemsUseCase>();
  }

  TaskDeleteItemUseCase getTaskDeleteUseCase() {
    return getIt<TaskDeleteItemUseCase>();
  }

  TaskCreateUpdateUseCase getTaskCreateUpdateUseCase() {
    return getIt<TaskCreateUpdateUseCase>();
  }

  CategoryDeleteUseCase getCategoryDeleteUseCase() {
    return getIt<CategoryDeleteUseCase>();
  }

  CategoryCreateOrUpdateUseCase getCategoryCreateOrUpdateUseCase() {
    return getIt<CategoryCreateOrUpdateUseCase>();
  }

  CategoryRetrieveAllItemsUseCase getCategoryRetrieveAllItemsUseCase() {
    return getIt<CategoryRetrieveAllItemsUseCase>();
  }

  PriorityCreateUseCase getPriorityCreateUseCase() {
    return getIt<PriorityCreateUseCase>();
  }

  PriorityRetrieveAllItemsUseCase getPriorityRetrieveAllItemsUseCase() {
    return getIt<PriorityRetrieveAllItemsUseCase>();
  }

  SettingRetrieveUseCase getSettingRetrieveUseCase() {
    return getIt<SettingRetrieveUseCase>();
  }

  SettingCreateUpdateUseCase getSettingCreateUpdateUseCase() {
    return getIt<SettingCreateUpdateUseCase>();
  }
}
