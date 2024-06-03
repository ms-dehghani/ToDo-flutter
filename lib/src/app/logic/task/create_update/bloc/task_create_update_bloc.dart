import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/usecase/task/createupdate/task_create_update_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/page_status.dart';
import 'task_create_update_event.dart';
import 'task_create_update_page_data.dart';

class TaskCreateOrUpdateBloc
    extends Bloc<TaskCreateOrUpdateEvent, TaskCreateUpdateBlocPageData> {
  final TaskCreateUpdateUseCase _createUpdateUseCase;

  TaskCreateOrUpdateBloc(
      {TaskItem? taskItem,
      required TaskCreateUpdateUseCase createUpdateUseCase})
      : _createUpdateUseCase = createUpdateUseCase,
        super(TaskCreateUpdateBlocPageData(
            item: taskItem, status: PageStatus.initial)) {
    on<TaskCreateOrUpdateEvent>(_createOrUpdateTask);
  }

  Future<void> _createOrUpdateTask(TaskCreateOrUpdateEvent event,
      Emitter<TaskCreateUpdateBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));
    if (event.taskItem.title.isEmpty ||
        event.taskItem.priorityItem == null ||
        event.taskItem.categoryItem == null) {
      emit.call(state.copyWith(status: PageStatus.failure));
    } else {
      TaskItem taskItem = await _createUpdateUseCase.invoke(event.taskItem);
      emit.call(state.copyWith(
          status:
              taskItem.ID.isNotEmpty ? PageStatus.success : PageStatus.failure,
          item: taskItem));
    }
  }
}
