import 'package:ToDo/src/domain/models/category/category_item.dart';

abstract class CategoryCreateOrUpdateItemRepository {
  Future<CategoryItem> createOrUpdateCategory(CategoryItem categoryItem);
}
