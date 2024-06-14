import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/repositories/category/retrieve/item/category_retrieve_item_repository.dart';

class CategoryRetrieveItemUseCase {
  late final CategoryRetrieveItemRepository _repository;

  CategoryRetrieveItemUseCase(
      {required CategoryRetrieveItemRepository repository}) {
    _repository = repository;
  }

  Future<CategoryItem?> invoke(String categoryID) {
    return _repository.getCategory(categoryID);
  }
}
