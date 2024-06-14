import 'package:ToDo/src/domain/usecase/category/delete/category_delete_item_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/page_status.dart';
import 'category_delete_event.dart';
import 'category_delete_page_data.dart';

class CategoryDeleteBloc
    extends Bloc<CategoryDeleteEvent, CategoryDeleteBlocPageData> {
  final CategoryDeleteUseCase _categoryUseCase;

  CategoryDeleteBloc({required CategoryDeleteUseCase categoryUseCase})
      : _categoryUseCase = categoryUseCase,
        super(CategoryDeleteBlocPageData(status: PageStatus.initial)) {
    on<CategoryDeleteEvent>(_deleteTask);
  }

  Future<void> _deleteTask(CategoryDeleteEvent event,
      Emitter<CategoryDeleteBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    bool result = await _categoryUseCase.invoke(event.taskID);

    emit.call(state.copyWith(
        status: result ? PageStatus.success : PageStatus.failure));
  }
}
