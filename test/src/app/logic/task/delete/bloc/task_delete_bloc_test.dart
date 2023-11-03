import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/task/delete/bloc/task_delete_bloc.dart';
import 'package:ToDo/src/app/logic/task/delete/bloc/task_delete_event.dart';
import 'package:ToDo/src/app/logic/task/delete/bloc/task_delete_page_data.dart';
import 'package:ToDo/src/domain/usecase/task/task_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_delete_bloc_test.mocks.dart';

@GenerateMocks([TaskUseCase])
void main() {
  late TaskDeleteBloc deleteBloc;
  late TaskUseCase taskUseCase;

  setUp(() {
    EquatableConfig.stringify = true;
    taskUseCase = MockTaskUseCase();
    deleteBloc = TaskDeleteBloc(taskUseCase: taskUseCase);
  });

  group("Delete task", () {
    blocTest<TaskDeleteBloc, TaskDeleteBlocPageData>(
      "Delete failure",
      build: () {
        when(taskUseCase.deleteTask("")).thenAnswer((realInvocation) {
          return Future.value(false);
        });
        return deleteBloc;
      },
      act: (bloc) => bloc.add(TaskDeleteEvent(id: "")),
      expect: () => <TaskDeleteBlocPageData>[
        TaskDeleteBlocPageData(status: PageStatus.loading),
        TaskDeleteBlocPageData(status: PageStatus.failure)
      ],
      verify: (bloc) {
        verify(taskUseCase.deleteTask("")).called(1);
      },
    );

    blocTest<TaskDeleteBloc, TaskDeleteBlocPageData>(
      "Delete success",
      build: () {
        when(taskUseCase.deleteTask("")).thenAnswer((realInvocation) {
          return Future.value(true);
        });
        return deleteBloc;
      },
      act: (bloc) => bloc.add(TaskDeleteEvent(id: "")),
      expect: () => <TaskDeleteBlocPageData>[
        TaskDeleteBlocPageData(status: PageStatus.loading),
        TaskDeleteBlocPageData(status: PageStatus.success)
      ],
      verify: (bloc) {
        verify(taskUseCase.deleteTask("")).called(1);
      },
    );
  });

  tearDown(() {
    deleteBloc.close();
  });
}
