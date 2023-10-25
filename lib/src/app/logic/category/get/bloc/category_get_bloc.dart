import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';
import 'package:kardone/src/model/items/tasks/category/repo/category_repository.dart';
import '../../../base/page_status.dart';
import 'category_get_event.dart';
import 'category_get_page_data.dart';

class CategoryGetBloc extends Bloc<GetAllCategoryEvent, CategoryGetBlocPageData> {
  final CategoryRepository _categoryRepository;

  CategoryGetBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryGetBlocPageData(status: PageStatus.initial)) {
    on<GetAllCategoryEvent>(_getAllCategory);
  }

  Future<void> _getAllCategory(
      GetAllCategoryEvent event, Emitter<CategoryGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    List<CategoryItem> categoryList = await _categoryRepository.getCategories();

    emit.call(state.copyWith(categoryList: categoryList, status: PageStatus.success));
  }
}
