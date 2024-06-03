import 'package:ToDo/src/domain/models/category/category_item.dart';

abstract class CategoryRetrieveItemRepository {
  Future<CategoryItem?> getCategory(String categoryID);
}
