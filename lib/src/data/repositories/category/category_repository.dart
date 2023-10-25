import 'package:kardone/src/data/datasource/category/category_data_provider.dart';
import 'package:kardone/src/domain/models/category/category_item.dart';
import 'package:kardone/src/domain/repositories/category/category_item_repository.dart';

class CategoryRepository implements CategoryItemRepository {
  static CategoryRepository? _categoryRepository;

  static CategoryRepository init(CategoryDataProvider localDB, CategoryDataProvider? api) {
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

  late CategoryDataProvider localDB;
  CategoryDataProvider? api;

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
