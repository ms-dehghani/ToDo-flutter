import '../pojo/category_item.dart';

abstract class CategoryItemDataProviderImpl {
  Future<CategoryItem?> getCategory(String categoryID);

  Future<List<CategoryItem>> getCategories();

  Future<CategoryItem> createOrUpdateCategory(CategoryItem categoryItem);

  Future<bool> deleteCategory(String categoryID);

  Future<void> clear();
}
