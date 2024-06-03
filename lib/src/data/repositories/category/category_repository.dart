import 'package:ToDo/src/data/datasource/category/category_data_provider.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/repositories/category/clear/category_clear_items_repository.dart';
import 'package:ToDo/src/domain/repositories/category/createupdate/category_create_or_update_item_repository.dart';
import 'package:ToDo/src/domain/repositories/category/delete/category_delete_item_repository.dart';
import 'package:ToDo/src/domain/repositories/category/retrieve/all/category_retrieve_all_items_repository.dart';
import 'package:ToDo/src/domain/repositories/category/retrieve/item/category_retrieve_item_repository.dart';

class CategoryRepository
    implements
        CategoryCreateOrUpdateItemRepository,
        CategoryClearItemsRepository,
        CategoryDeleteItemRepository,
        CategoryRetrieveAllItemsRepository,
        CategoryRetrieveItemRepository {
  CategoryDataProvider localDB;
  CategoryDataProvider? api;

  CategoryRepository(this.localDB, this.api);

  @override
  Future<void> clear() {
    return localDB.clear();
  }

  @override
  Future<CategoryItem> createOrUpdateCategory(CategoryItem categoryItem) {
    return localDB.createOrUpdateCategory(categoryItem);
  }

  @override
  Future<bool> deleteCategory(String categoryID) {
    return localDB.deleteCategory(categoryID);
  }

  @override
  Future<List<CategoryItem>> getCategories() {
    return localDB.getCategories();
  }

  @override
  Future<CategoryItem?> getCategory(String categoryID) {
    return localDB.getCategory(categoryID);
  }
}
