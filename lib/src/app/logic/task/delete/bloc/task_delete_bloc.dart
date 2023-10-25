import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/src/model/items/tasks/task/repo/task_repository.dart';

import '../../../base/page_status.dart';
import 'task_delete_event.dart';
import 'task_delete_page_data.dart';

class TaskDeleteBloc extends Bloc<TaskDeleteEvent, TaskDeleteBlocPageData> {
  TaskRepository taskRepository;

  TaskDeleteBloc({required this.taskRepository})
      : super(TaskDeleteBlocPageData(status: PageStatus.initial)) {
    on<TaskDeleteEvent>(_deleteTask);
  }

  Future<void> _deleteTask(TaskDeleteEvent event, Emitter<TaskDeleteBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    bool result = await taskRepository.deleteTask(event.taskID);

    emit.call(state.copyWith(status: result ? PageStatus.success : PageStatus.failure));
  }
}
