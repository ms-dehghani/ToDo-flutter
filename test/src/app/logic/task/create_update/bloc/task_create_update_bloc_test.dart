import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_bloc.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_event.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_page_data.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/usecase/task/task_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_create_update_bloc_test.mocks.dart';

@GenerateMocks([TaskUseCase])
void main() {
  late TaskCreateOrUpdateBloc taskBloc;
  late TaskUseCase taskUseCase;

  setUp(() {
    EquatableConfig.stringify = true;
    taskUseCase = MockTaskUseCase();
    taskBloc = TaskCreateOrUpdateBloc(taskUseCase: taskUseCase);
  });

  group("Create task", () {
    var taskItem = TaskItem(
        id: "id",
        title: "s",
        description: "",
        categoryItem: CategoryItem.empty(),
        priorityItem: PriorityItem.empty());

    var emptyIDTask = taskItem.copyWith(taskId: "");

    blocTest<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      "Given empty task to create Then return failure",
      build: () {
        return taskBloc;
      },
      act: (bloc) => bloc.add(TaskCreateOrUpdateEvent(TaskItem.empty())),
      expect: () => <TaskCreateUpdateBlocPageData>[
        TaskCreateUpdateBlocPageData(status: PageStatus.loading, item: null),
        TaskCreateUpdateBlocPageData(status: PageStatus.failure, item: null)
      ],
      verify: (bloc) {
        verifyNever(taskUseCase.createOrUpdateTask(TaskItem.empty()));
      },
    );

    blocTest<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      "Given task without id to create Then return failure",
      build: () {
        when(taskUseCase.createOrUpdateTask(emptyIDTask)).thenAnswer((realInvocation) {
          return Future.value(realInvocation.positionalArguments[0]);
        });
        return taskBloc;
      },
      act: (bloc) => bloc.add(TaskCreateOrUpdateEvent(emptyIDTask)),
      expect: () => <TaskCreateUpdateBlocPageData>[
        TaskCreateUpdateBlocPageData(status: PageStatus.loading, item: null),
        TaskCreateUpdateBlocPageData(status: PageStatus.failure, item: emptyIDTask)
      ],
      verify: (bloc) {
        verify(taskUseCase.createOrUpdateTask(emptyIDTask)).called(1);
      },
    );

    blocTest<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      "Given task without title to create Then return failure",
      build: () {
        return taskBloc;
      },
      act: (bloc) {
        var item = TaskItem.empty().copyWith(taskId: "d", title: "");
        bloc.add(TaskCreateOrUpdateEvent(item));
      },
      expect: () => <TaskCreateUpdateBlocPageData>[
        TaskCreateUpdateBlocPageData(status: PageStatus.loading, item: null),
        TaskCreateUpdateBlocPageData(status: PageStatus.failure, item: null)
      ],
      verify: (bloc) {
        verifyNever(taskUseCase.createOrUpdateTask(emptyIDTask));
      },
    );

    blocTest<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      "Given task without priority to create Then return failure",
      build: () {
        return taskBloc;
      },
      act: (bloc) {
        var item = TaskItem.empty().copyWith(taskId: "d", title: "t");
        bloc.add(TaskCreateOrUpdateEvent(item));
      },
      expect: () => <TaskCreateUpdateBlocPageData>[
        TaskCreateUpdateBlocPageData(status: PageStatus.loading, item: null),
        TaskCreateUpdateBlocPageData(status: PageStatus.failure, item: null)
      ],
      verify: (bloc) {
        verifyNever(taskUseCase.createOrUpdateTask(emptyIDTask));
      },
    );

    blocTest<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      "Given task without category to create Then return failure",
      build: () {
        return taskBloc;
      },
      act: (bloc) {
        var item =
            TaskItem.empty().copyWith(taskId: "d", title: "t", priorityItem: PriorityItem.empty());
        bloc.add(TaskCreateOrUpdateEvent(item));
      },
      expect: () => <TaskCreateUpdateBlocPageData>[
        TaskCreateUpdateBlocPageData(status: PageStatus.loading, item: null),
        TaskCreateUpdateBlocPageData(status: PageStatus.failure, item: null)
      ],
      verify: (bloc) {
        verifyNever(taskUseCase.createOrUpdateTask(emptyIDTask));
      },
    );

    blocTest<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      "Given task to create but not added to DB Then return failure",
      build: () {
        when(taskUseCase.createOrUpdateTask(taskItem)).thenAnswer((realInvocation) {
          return Future.value(taskItem.copyWith(taskId: ""));
        });
        return taskBloc;
      },
      act: (bloc) => bloc.add(TaskCreateOrUpdateEvent(taskItem)),
      expect: () => <TaskCreateUpdateBlocPageData>[
        TaskCreateUpdateBlocPageData(status: PageStatus.loading, item: null),
        TaskCreateUpdateBlocPageData(status: PageStatus.failure, item: taskItem.copyWith(taskId: ""))
      ],
      verify: (bloc) {
        verify(taskUseCase.createOrUpdateTask(taskItem)).called(1);
      },
    );

    blocTest<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      "Given task to create Then return success",
      build: () {
        when(taskUseCase.createOrUpdateTask(taskItem)).thenAnswer((realInvocation) {
          return Future.value(realInvocation.positionalArguments[0]);
        });
        return taskBloc;
      },
      act: (bloc) => bloc.add(TaskCreateOrUpdateEvent(taskItem)),
      expect: () => <TaskCreateUpdateBlocPageData>[
        TaskCreateUpdateBlocPageData(status: PageStatus.loading, item: null),
        TaskCreateUpdateBlocPageData(status: PageStatus.success, item: taskItem)
      ],
      verify: (bloc) {
        verify(taskUseCase.createOrUpdateTask(taskItem)).called(1);
      },
    );
  });

  tearDown(() {
    taskBloc.close();
  });
}
