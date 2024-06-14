import 'package:ToDo/src/domain/repositories/category/delete/category_delete_item_repository.dart';

class CategoryDeleteUseCase {
  late final CategoryDeleteItemRepository _repository;

  CategoryDeleteUseCase({required CategoryDeleteItemRepository repository}) {
    _repository = repository;
  }

  Future<bool> invoke(String categoryID) {
    return _repository.deleteCategory(categoryID);
  }
}
