import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/task/get/bloc/task_get_bloc.dart';
import 'package:ToDo/src/app/logic/task/get/bloc/task_get_event.dart';
import 'package:ToDo/src/app/logic/task/get/bloc/task_get_page_data.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/usecase/task/task_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_get_bloc_test.mocks.dart';

@GenerateMocks([TaskUseCase])
void main() {
  late TaskGetBloc taskBloc;
  late TaskUseCase taskUseCase;

  setUp(() {
    EquatableConfig.stringify = true;
    taskUseCase = MockTaskUseCase();
    taskBloc = TaskGetBloc(taskUseCase: taskUseCase);
  });

  group("Get Day task list", () {
    var today = DateTime.now();

    blocTest<TaskGetBloc, TaskGetBlocPageData>(
      "Emit GetAllTaskInDayEvent then call get empty task list",
      build: () {
        when(taskUseCase.getTaskListFromData(today.millisecondsSinceEpoch))
            .thenAnswer((realInvocation) => Future.value([]));
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetAllTaskInDayEvent(today.millisecondsSinceEpoch)),
      expect: () => <TaskGetBlocPageData>[
        TaskGetBlocPageData(status: PageStatus.loading, taskList: [], calenderDetail: {}),
        TaskGetBlocPageData(status: PageStatus.success, taskList: [], calenderDetail: {})
      ],
      verify: (bloc) {
        verify(taskUseCase.getTaskListFromData(today.millisecondsSinceEpoch)).called(1);
      },
    );

    var taskItem = TaskItem.empty();

    blocTest<TaskGetBloc, TaskGetBlocPageData>(
      "Emit GetAllTaskInDayEvent then call get today tasks",
      build: () {
        when(taskUseCase.getTaskListFromData(today.millisecondsSinceEpoch))
            .thenAnswer((realInvocation) => Future.value([taskItem]));
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetAllTaskInDayEvent(today.millisecondsSinceEpoch)),
      expect: () => <TaskGetBlocPageData>[
        TaskGetBlocPageData(status: PageStatus.loading, taskList: [], calenderDetail: {}),
        TaskGetBlocPageData(status: PageStatus.success, taskList: [taskItem], calenderDetail: {})
      ],
      verify: (bloc) {
        verify(taskUseCase.getTaskListFromData(today.millisecondsSinceEpoch)).called(1);
      },
    );
  });

  group("Get calender task", () {
    var today = DateTime.now();

    blocTest<TaskGetBloc, TaskGetBlocPageData>(
      "Emit GetAllTaskInCalenderEvent then get empty task list and empty calender detail",
      build: () {
        when(taskUseCase.getTaskListFromData(1)).thenAnswer((realInvocation) => Future.value([]));
        when(taskUseCase.isAnyTaskExistInRange(
                today.millisecondsSinceEpoch, today.millisecondsSinceEpoch))
            .thenAnswer((realInvocation) => Future.value({}));
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetAllTaskInCalenderEvent(
          startTime: today.millisecondsSinceEpoch,
          endTime: today.millisecondsSinceEpoch,
          selectedDay: 1)),
      expect: () => <TaskGetBlocPageData>[
        TaskGetBlocPageData(status: PageStatus.loading, taskList: [], calenderDetail: {}),
        TaskGetBlocPageData(status: PageStatus.success, taskList: [], calenderDetail: {})
      ],
      verify: (bloc) {
        verify(taskUseCase.getTaskListFromData(1)).called(1);
        verify(taskUseCase.isAnyTaskExistInRange(
                today.millisecondsSinceEpoch, today.millisecondsSinceEpoch))
            .called(1);
      },
    );

    var taskItem = TaskItem.empty();

    blocTest<TaskGetBloc, TaskGetBlocPageData>(
      "Emit GetAllTaskInCalenderEvent then get empty task list and empty calender detail",
      build: () {
        when(taskUseCase.getTaskListFromData(1))
            .thenAnswer((realInvocation) => Future.value([taskItem]));
        when(taskUseCase.isAnyTaskExistInRange(
                today.millisecondsSinceEpoch, today.millisecondsSinceEpoch))
            .thenAnswer((realInvocation) => Future.value({1: false, 2: true}));
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetAllTaskInCalenderEvent(
          startTime: today.millisecondsSinceEpoch,
          endTime: today.millisecondsSinceEpoch,
          selectedDay: 1)),
      expect: () => <TaskGetBlocPageData>[
        TaskGetBlocPageData(status: PageStatus.loading, taskList: [], calenderDetail: {}),
        TaskGetBlocPageData(
            status: PageStatus.success, taskList: [taskItem], calenderDetail: {1: false, 2: true})
      ],
      verify: (bloc) {
        verify(taskUseCase.getTaskListFromData(1)).called(1);
        verify(taskUseCase.isAnyTaskExistInRange(
                today.millisecondsSinceEpoch, today.millisecondsSinceEpoch))
            .called(1);
      },
    );
  });

  tearDown(() {
    taskBloc.close();
  });
}
