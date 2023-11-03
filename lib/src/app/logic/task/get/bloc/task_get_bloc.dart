import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/usecase/task/task_usecase.dart';

import '../../../base/page_status.dart';
import 'task_get_event.dart';
import 'task_get_page_data.dart';

class TaskGetBloc extends Bloc<TaskGetEvent, TaskGetBlocPageData> {
  final TaskUseCase _taskUseCase;

  TaskGetBloc({required TaskUseCase taskUseCase})
      : _taskUseCase = taskUseCase,
        super(TaskGetBlocPageData(status: PageStatus.initial)) {
    on<GetAllTaskInDayEvent>(_getAllDayTask);
    on<RefreshTaskListEvent>(_refreshTaskList);
    on<GetAllTaskInCalenderEvent>(_getAllCalenderTask);
  }

  Future<void> _getAllDayTask(GetAllTaskInDayEvent event, Emitter<TaskGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    List<TaskItem> taskList = await _taskUseCase.getTaskListFromData(event.dayTimestamp);

    emit.call(state.copyWith(taskList: taskList, status: PageStatus.success));
  }

  Future<void> _getAllCalenderTask(
      GetAllTaskInCalenderEvent event, Emitter<TaskGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    var calDetail = await _taskUseCase.isAnyTaskExistInRange(event.startTime, event.endTime);
    var todayList = await _taskUseCase.getTaskListFromData(DateTime.now().millisecondsSinceEpoch);

    emit.call(
        state.copyWith(calenderDetail: calDetail, taskList: todayList, status: PageStatus.success));
  }

  Future<void> _refreshTaskList(
      RefreshTaskListEvent event, Emitter<TaskGetBlocPageData> emit) async {
    await _getAllDayTask(event, emit);
  }
}
