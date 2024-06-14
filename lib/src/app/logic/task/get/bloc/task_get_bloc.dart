import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/usecase/task/existence/task_check_existence_usecase.dart';
import 'package:ToDo/src/domain/usecase/task/retrieve/daylist/task_retrieve_day_list_items_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/page_status.dart';
import 'task_get_event.dart';
import 'task_get_page_data.dart';

class TaskGetBloc extends Bloc<TaskGetEvent, TaskGetBlocPageData> {
  final TaskRetrieveDayListItemsUseCase _dayListItemsUseCase;
  final TaskCheckExistenceUseCase _checkExistenceUseCase;

  TaskGetBloc(
      {required TaskRetrieveDayListItemsUseCase dayListItemsUseCase,
      required TaskCheckExistenceUseCase checkExistenceUseCase})
      : _dayListItemsUseCase = dayListItemsUseCase,
        _checkExistenceUseCase = checkExistenceUseCase,
        super(TaskGetBlocPageData(status: PageStatus.initial)) {
    on<GetAllTaskInDayEvent>(_getAllDayTask);
    on<GetAllTaskInCalenderEvent>(_getAllCalenderTask);
  }

  Future<void> _getAllDayTask(
      GetAllTaskInDayEvent event, Emitter<TaskGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    List<TaskItem> taskList =
        await _dayListItemsUseCase.invoke(event.dayTimestamp);

    emit.call(state.copyWith(taskList: taskList, status: PageStatus.success));
  }

  Future<void> _getAllCalenderTask(GetAllTaskInCalenderEvent event,
      Emitter<TaskGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    var calDetail =
        await _checkExistenceUseCase.invoke(event.startTime, event.endTime);
    var todayList = await _dayListItemsUseCase.invoke(event.selectedDay);

    emit.call(state.copyWith(
        calenderDetail: calDetail,
        taskList: todayList,
        status: PageStatus.success));
  }
}
