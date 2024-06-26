import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/usecase/category/createupdate/category_create_or_update_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/page_status.dart';
import 'category_create_update_event.dart';
import 'category_create_update_page_data.dart';

class CategoryCreateOrUpdateBloc extends Bloc<CategoryCreateOrUpdateEvent,
    CategoryCreateUpdateBlocPageData> {
  final CategoryCreateOrUpdateUseCase _categoryUseCase;

  CategoryCreateOrUpdateBloc(
      {CategoryItem? categoryItem,
      required CategoryCreateOrUpdateUseCase categoryUseCase})
      : _categoryUseCase = categoryUseCase,
        super(CategoryCreateUpdateBlocPageData(
            item: categoryItem, status: PageStatus.initial)) {
    on<CategoryCreateOrUpdateResultEvent>(_createOrUpdateTask);
    on<UpdateUI>(_updateUI);
  }

  Future<void> _createOrUpdateTask(CategoryCreateOrUpdateResultEvent event,
      Emitter<CategoryCreateUpdateBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));
    if (event.catItem.title.isEmpty) {
      emit.call(state.copyWith(status: PageStatus.failure));
    } else {
      CategoryItem catItem = await _categoryUseCase.invoke(event.catItem);
      emit.call(state.copyWith(
          status:
              catItem.ID.isNotEmpty ? PageStatus.success : PageStatus.failure,
          item: catItem));
    }
  }

  Future<void> _updateUI(
      UpdateUI event, Emitter<CategoryCreateUpdateBlocPageData> emit) async {
    emit.call(state.copyWith(
        status: state.pageStatus == PageStatus.loading
            ? PageStatus.initial
            : PageStatus.loading));
  }
}
