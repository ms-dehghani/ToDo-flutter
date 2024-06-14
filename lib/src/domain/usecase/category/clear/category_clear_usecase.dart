import 'package:ToDo/src/domain/repositories/category/clear/category_clear_items_repository.dart';

class CategoryClearUseCase {
  late final CategoryClearItemsRepository _repository;

  CategoryClearUseCase({required CategoryClearItemsRepository repository}) {
    _repository = repository;
  }

  Future<void> invoke() {
    return _repository.clear();
  }
}
