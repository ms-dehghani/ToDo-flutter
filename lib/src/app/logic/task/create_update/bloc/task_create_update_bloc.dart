import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/model/items/tasks/task/repo/task_repository.dart';

import '../../../base/page_status.dart';
import 'task_create_update_event.dart';
import 'task_create_update_page_data.dart';

class TaskCreateOrUpdateBloc extends Bloc<TaskCreateOrUpdateEvent, TaskCreateUpdateBlocPageData> {
  final TaskRepository _taskRepository;

  TaskCreateOrUpdateBloc({TaskItem? taskItem, required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskCreateUpdateBlocPageData(item: taskItem, status: PageStatus.initial)) {
    on<TaskCreateOrUpdateEvent>(_createOrUpdateTask);
  }

  Future<void> _createOrUpdateTask(
      TaskCreateOrUpdateEvent event, Emitter<TaskCreateUpdateBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));
    if (event.taskItem.title.isEmpty || event.taskItem.priorityItem == null) {
      emit.call(state.copyWith(status: PageStatus.failure));
    } else {
      TaskItem taskItem = await _taskRepository.createOrUpdateTask(event.taskItem);
      emit.call(state.copyWith(
          status: taskItem.ID.isNotEmpty ? PageStatus.success : PageStatus.failure,
          item: taskItem));
    }
  }
}
