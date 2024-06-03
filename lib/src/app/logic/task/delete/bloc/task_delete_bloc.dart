import 'package:ToDo/src/domain/usecase/task/delete/task_delete_item_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/page_status.dart';
import 'task_delete_event.dart';
import 'task_delete_page_data.dart';

class TaskDeleteBloc extends Bloc<TaskDeleteEvent, TaskDeleteBlocPageData> {
  final TaskDeleteItemUseCase _taskDeleteItemUseCase;

  TaskDeleteBloc({required TaskDeleteItemUseCase taskDeleteItemUseCase})
      : _taskDeleteItemUseCase = taskDeleteItemUseCase,
        super(TaskDeleteBlocPageData(status: PageStatus.initial)) {
    on<TaskDeleteEvent>(_deleteTask);
  }

  Future<void> _deleteTask(
      TaskDeleteEvent event, Emitter<TaskDeleteBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    bool result = await _taskDeleteItemUseCase.invoke(event.taskID);

    emit.call(state.copyWith(
        status: result ? PageStatus.success : PageStatus.failure));
  }
}
