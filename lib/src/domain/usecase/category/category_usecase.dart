import 'package:kardone/src/domain/repositories/category/category_item_repository.dart';

import '../../models/category/category_item.dart';

class CategoryUseCase {
  static CategoryUseCase? _useCase;

  static CategoryUseCase init(CategoryItemRepository repository) {
    return _useCase ??= CategoryUseCase._internal(repository: repository);
  }

  static CategoryUseCase instance() {
    return _useCase!;
  }

  late final CategoryItemRepository _repository;

  CategoryUseCase._internal({required CategoryItemRepository repository}) {
    _repository = repository;
  }

  Future<CategoryItem?> getCategory(String categoryID) {
    return _repository.getCategory(categoryID);
  }

  Future<List<CategoryItem>> getCategories() {
    return _repository.getCategories();
  }

  Future<CategoryItem> createOrUpdateCategory(CategoryItem categoryItem) {
    return _repository.createOrUpdateCategory(categoryItem);
  }

  Future<bool> deleteCategory(String categoryID) {
    return _repository.deleteCategory(categoryID);
  }

  Future<void> clear() {
    return _repository.clear();
  }
}
