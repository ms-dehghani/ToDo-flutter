import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/src/domain/usecase/category/category_usecase.dart';

import '../../../base/page_status.dart';
import 'category_delete_event.dart';
import 'category_delete_page_data.dart';

class CategoryDeleteBloc extends Bloc<CategoryDeleteEvent, CategoryDeleteBlocPageData> {
  final CategoryUseCase _categoryUseCase;

  CategoryDeleteBloc({required CategoryUseCase categoryRepository})
      : _categoryUseCase = categoryRepository,
        super(CategoryDeleteBlocPageData(status: PageStatus.initial)) {
    on<CategoryDeleteEvent>(_deleteTask);
  }

  Future<void> _deleteTask(
      CategoryDeleteEvent event, Emitter<CategoryDeleteBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    bool result = await _categoryUseCase.deleteCategory(event.taskID);

    emit.call(state.copyWith(status: result ? PageStatus.success : PageStatus.failure));
  }
}
