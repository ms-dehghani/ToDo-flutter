import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/all/category_retrieve_all_items_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/page_status.dart';
import 'category_get_event.dart';
import 'category_get_page_data.dart';

class CategoryGetBloc
    extends Bloc<GetAllCategoryEvent, CategoryGetBlocPageData> {
  final CategoryRetrieveAllItemsUseCase _categoryAllItemsUseCase;

  CategoryGetBloc({
    required CategoryRetrieveAllItemsUseCase categoryAllItemsUseCase,
  })  : _categoryAllItemsUseCase = categoryAllItemsUseCase,
        super(CategoryGetBlocPageData(status: PageStatus.initial)) {
    on<GetAllCategoryEvent>(_getAllCategory);
  }

  Future<void> _getAllCategory(
      GetAllCategoryEvent event, Emitter<CategoryGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    List<CategoryItem> categoryList = await _categoryAllItemsUseCase.invoke();

    emit.call(
        state.copyWith(categoryList: categoryList, status: PageStatus.success));
  }
}
