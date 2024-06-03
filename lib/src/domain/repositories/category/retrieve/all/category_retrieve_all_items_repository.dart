import 'package:ToDo/src/domain/models/category/category_item.dart';

abstract class CategoryRetrieveAllItemsRepository {
  Future<List<CategoryItem>> getCategories();
}
