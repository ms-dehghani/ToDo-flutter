import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/src/domain/models/category/category_item.dart';
import 'package:kardone/src/domain/usecase/category/category_usecase.dart';
import '../../../base/page_status.dart';
import 'category_get_event.dart';
import 'category_get_page_data.dart';

class CategoryGetBloc extends Bloc<GetAllCategoryEvent, CategoryGetBlocPageData> {
  final CategoryUseCase _categoryUseCase;

  CategoryGetBloc({required CategoryUseCase categoryRepository})
      : _categoryUseCase = categoryRepository,
        super(CategoryGetBlocPageData(status: PageStatus.initial)) {
    on<GetAllCategoryEvent>(_getAllCategory);
  }

  Future<void> _getAllCategory(
      GetAllCategoryEvent event, Emitter<CategoryGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    List<CategoryItem> categoryList = await _categoryUseCase.getCategories();

    emit.call(state.copyWith(categoryList: categoryList, status: PageStatus.success));
  }
}
