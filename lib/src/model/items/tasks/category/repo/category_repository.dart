import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';
import '../data_provider/category_item_data_provider_impl.dart';

class CategoryRepository implements CategoryItemDataProviderImpl {
  static CategoryRepository? _categoryRepository;

  static CategoryRepository init(
      CategoryItemDataProviderImpl localDB, CategoryItemDataProviderImpl? api) {
    if (_categoryRepository == null) {
      _categoryRepository = CategoryRepository._internal();
      _categoryRepository!.api = api;
      _categoryRepository!.localDB = localDB;
    }
    return _categoryRepository!;
  }

  static CategoryRepository instance() {
    return _categoryRepository!;
  }

  late CategoryItemDataProviderImpl localDB;
  CategoryItemDataProviderImpl? api;

  CategoryRepository._internal();

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
