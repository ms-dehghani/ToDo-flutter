

import 'package:ToDo/src/domain/models/category/category_item.dart';

abstract class CategoryDataProvider {
  Future<CategoryItem?> getCategory(String categoryID);

  Future<List<CategoryItem>> getCategories();

  Future<CategoryItem> createOrUpdateCategory(CategoryItem categoryItem);

  Future<bool> deleteCategory(String categoryID);

  Future<void> clear();
}
