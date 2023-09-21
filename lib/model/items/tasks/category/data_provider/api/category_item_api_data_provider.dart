import 'package:kardone/arch/base_model.dart';

import '../../pojo/category_item.dart';
import '../category_item_data_provider_impl.dart';

class CategoryItemApiDataProvider extends BaseModel implements CategoryItemDataProviderImpl {
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
}
