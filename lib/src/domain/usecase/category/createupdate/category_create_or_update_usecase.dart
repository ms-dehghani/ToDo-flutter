import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/repositories/category/createupdate/category_create_or_update_item_repository.dart';

class CategoryCreateOrUpdateUseCase {
  late final CategoryCreateOrUpdateItemRepository _repository;

  CategoryCreateOrUpdateUseCase(
      {required CategoryCreateOrUpdateItemRepository repository}) {
    _repository = repository;
  }

  Future<CategoryItem> invoke(CategoryItem categoryItem) {
    return _repository.createOrUpdateCategory(categoryItem);
  }
}
