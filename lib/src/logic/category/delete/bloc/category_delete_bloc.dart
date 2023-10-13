import 'package:kardone/src/logic/base/page_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/src/model/items/tasks/category/repo/category_repository.dart';

import 'category_delete_event.dart';
import 'category_delete_page_data.dart';

class CategoryDeleteBloc extends Bloc<CategoryDeleteEvent, CategoryDeleteBlocPageData> {
  final CategoryRepository _categoryRepository;

  CategoryDeleteBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryDeleteBlocPageData(status: PageStatus.initial)) {
    on<CategoryDeleteEvent>(_deleteTask);
  }

  Future<void> _deleteTask(
      CategoryDeleteEvent event, Emitter<CategoryDeleteBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    bool result = await _categoryRepository.deleteCategory(event.taskID);

    emit.call(state.copyWith(status: result ? PageStatus.success : PageStatus.failure));
  }
}
