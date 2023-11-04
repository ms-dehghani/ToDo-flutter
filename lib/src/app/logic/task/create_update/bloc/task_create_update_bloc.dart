import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/usecase/task/task_usecase.dart';

import '../../../base/page_status.dart';
import 'task_create_update_event.dart';
import 'task_create_update_page_data.dart';

class TaskCreateOrUpdateBloc extends Bloc<TaskCreateOrUpdateEvent, TaskCreateUpdateBlocPageData> {
  final TaskUseCase _taskUseCase;

  TaskCreateOrUpdateBloc({TaskItem? taskItem, required TaskUseCase taskUseCase})
      : _taskUseCase = taskUseCase,
        super(TaskCreateUpdateBlocPageData(item: taskItem, status: PageStatus.initial)) {
    on<TaskCreateOrUpdateEvent>(_createOrUpdateTask);
  }

  Future<void> _createOrUpdateTask(
      TaskCreateOrUpdateEvent event, Emitter<TaskCreateUpdateBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));
    if (event.taskItem.title.isEmpty ||
        event.taskItem.priorityItem == null ||
        event.taskItem.categoryItem == null) {
      emit.call(state.copyWith(status: PageStatus.failure));
    } else {
      TaskItem taskItem = await _taskUseCase.createOrUpdateTask(event.taskItem);
      emit.call(state.copyWith(
          status: taskItem.ID.isNotEmpty ? PageStatus.success : PageStatus.failure,
          item: taskItem));
    }
  }
}
