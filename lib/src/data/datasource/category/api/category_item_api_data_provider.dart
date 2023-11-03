import 'package:ToDo/src/base/base_model.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';

import '../category_data_provider.dart';

class CategoryItemApiDataProvider extends BaseModel implements CategoryDataProvider {
  @override
  Future<CategoryItem> createOrUpdateCategory(CategoryItem categoryItem) {
    // TODO: implement createOrUpdateCategory
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCategory(String categoryID) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryItem>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<CategoryItem?> getCategory(String categoryID) {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<void> clear() async {
    throw UnimplementedError();
  }
}
