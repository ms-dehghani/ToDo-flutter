import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/repositories/category/retrieve/all/category_retrieve_all_items_repository.dart';

class CategoryRetrieveAllItemsUseCase {
  late final CategoryRetrieveAllItemsRepository _repository;

  CategoryRetrieveAllItemsUseCase(
      {required CategoryRetrieveAllItemsRepository repository}) {
    _repository = repository;
  }

  Future<List<CategoryItem>> invoke() {
    return _repository.getCategories();
  }
}
