import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ToDo/src/domain/usecase/task/task_usecase.dart';

import '../../../base/page_status.dart';
import 'task_delete_event.dart';
import 'task_delete_page_data.dart';

class TaskDeleteBloc extends Bloc<TaskDeleteEvent, TaskDeleteBlocPageData> {
  final TaskUseCase _taskUseCase;

  TaskDeleteBloc({required TaskUseCase taskUseCase})
      : _taskUseCase = taskUseCase, super(TaskDeleteBlocPageData(status: PageStatus.initial)) {
    on<TaskDeleteEvent>(_deleteTask);
  }

  Future<void> _deleteTask(TaskDeleteEvent event, Emitter<TaskDeleteBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    bool result = await _taskUseCase.deleteTask(event.taskID);

    emit.call(state.copyWith(status: result ? PageStatus.success : PageStatus.failure));
  }
}
