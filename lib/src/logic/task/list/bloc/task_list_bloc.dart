import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/task/list/bloc/task_list_page_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/model/items/tasks/task/repo/task_repository.dart';

import 'task_list_event.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListPageData> {
  TaskRepository taskRepository;

  TaskListBloc({required this.taskRepository})
      : super(TaskListPageData(status: PageStatus.initial)) {
    on<GetAllTaskInDayEvent>(_getAllDayTask);
    on<RefreshTaskListEvent>(_refreshTaskList);
    on<GetAllTaskInCalenderEvent>(_getAllCalenderTask);
  }

  Future<void> _getAllDayTask(GetAllTaskInDayEvent event, Emitter<TaskListPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    List<TaskItem> taskList = await taskRepository.getTaskListFromData(event.dayTimestamp);

    emit.call(state.copyWith(taskList: taskList, status: PageStatus.finish));
  }

  Future<void> _getAllCalenderTask(
      GetAllTaskInCalenderEvent event, Emitter<TaskListPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    var calDetail = await taskRepository.isAnyTaskExistInRange(event.startTime, event.endTime);
    var todayList = await taskRepository.getTaskListFromData(DateTime.now().millisecondsSinceEpoch);

    emit.call(
        state.copyWith(calenderDetail: calDetail, taskList: todayList, status: PageStatus.finish));
  }

  Future<void> _refreshTaskList(RefreshTaskListEvent event, Emitter<TaskListPageData> emit) async {
    await _getAllDayTask(event, emit);
  }
}
