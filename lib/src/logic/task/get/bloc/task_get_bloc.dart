import 'package:kardone/src/logic/base/page_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/model/items/tasks/task/repo/task_repository.dart';

import 'task_get_event.dart';
import 'task_get_page_data.dart';

class TaskGetBloc extends Bloc<TaskGetEvent, TaskGetBlocPageData> {
  TaskRepository taskRepository;

  TaskGetBloc({required this.taskRepository})
      : super(TaskGetBlocPageData(status: PageStatus.initial)) {
    on<GetAllTaskInDayEvent>(_getAllDayTask);
    on<RefreshTaskListEvent>(_refreshTaskList);
    on<GetAllTaskInCalenderEvent>(_getAllCalenderTask);
  }

  Future<void> _getAllDayTask(GetAllTaskInDayEvent event, Emitter<TaskGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    List<TaskItem> taskList = await taskRepository.getTaskListFromData(event.dayTimestamp);

    emit.call(state.copyWith(taskList: taskList, status: PageStatus.success));
  }

  Future<void> _getAllCalenderTask(
      GetAllTaskInCalenderEvent event, Emitter<TaskGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    var calDetail = await taskRepository.isAnyTaskExistInRange(event.startTime, event.endTime);
    var todayList = await taskRepository.getTaskListFromData(DateTime.now().millisecondsSinceEpoch);

    emit.call(
        state.copyWith(calenderDetail: calDetail, taskList: todayList, status: PageStatus.success));
  }

  Future<void> _refreshTaskList(
      RefreshTaskListEvent event, Emitter<TaskGetBlocPageData> emit) async {
    await _getAllDayTask(event, emit);
  }
}
