import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/repositories/task/task_item_repository.dart';
import 'package:ToDo/src/domain/usecase/task/task_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_usecase_test.mocks.dart';

@GenerateMocks([TaskItemRepository])
void main() {
  late TaskUseCase usecase;
  late MockTaskItemRepository repository;

  setUpAll(() async {
    repository = MockTaskItemRepository();
    usecase = TaskUseCase(repository: repository);
  });

  test("When call clear then call clear on provider", () {
    when(repository.clear()).thenAnswer((realInvocation) => Future.value());
    usecase.clear();

    verify(repository.clear()).called(1);
  });

  test("When call deleteTask then call deleteTask on provider and return true", () async {
    when(repository.deleteTask(any)).thenAnswer((realInvocation) => Future.value(true));
    var result = await usecase.deleteTask("");

    expect(result, true);

    verify(repository.deleteTask(any)).called(1);
  });

  test("When call deleteTask then call deleteTask on provider and return false", () async {
    when(repository.deleteTask(any)).thenAnswer((realInvocation) => Future.value(false));
    var result = await usecase.deleteTask("");

    expect(result, false);

    verify(repository.deleteTask(any)).called(1);
  });

  test("When call createOrUpdateTask then call clear on provider", () async {
    var sampleTask = TaskItem.empty();
    when(repository.createOrUpdateTask(any))
        .thenAnswer((realInvocation) => Future.value(sampleTask));
    var result = await usecase.createOrUpdateTask(sampleTask);

    expect(result, sampleTask);

    verify(repository.createOrUpdateTask(any)).called(1);
  });

  test("When call isAnyTaskExistInDate then call isAnyTaskExistInDate on provider and return true",
      () async {
    when(repository.isAnyTaskExistInDate(any)).thenAnswer((realInvocation) => Future.value(true));
    var result = await usecase.isAnyTaskExistInDate(0);

    expect(result, true);

    verify(repository.isAnyTaskExistInDate(any)).called(1);
  });

  test("When call isAnyTaskExistInDate then call isAnyTaskExistInDate on provider and return false",
      () async {
    when(repository.isAnyTaskExistInDate(any)).thenAnswer((realInvocation) => Future.value(false));
    var result = await usecase.isAnyTaskExistInDate(0);

    expect(result, false);

    verify(repository.isAnyTaskExistInDate(any)).called(1);
  });

  test(
      "When call isAnyTaskExistInRange then call isAnyTaskExistInRange on provider and return true",
      () async {
    when(repository.isAnyTaskExistInRange(any, any))
        .thenAnswer((realInvocation) => Future.value({1: false, 2: true}));
    var result = await usecase.isAnyTaskExistInRange(0, 0);

    expect(result.length, 2);
    expect(result[1], false);
    expect(result[2], true);

    verify(repository.isAnyTaskExistInRange(any, any)).called(1);
  });

  test(
      "When call isAnyTaskExistInRange then call isAnyTaskExistInRange on provider and return "
      "empty", () async {
    when(repository.isAnyTaskExistInRange(any, any))
        .thenAnswer((realInvocation) => Future.value(<int, bool>{}));
    var result = await usecase.isAnyTaskExistInRange(0, 0);

    expect(result.length, 0);

    verify(repository.isAnyTaskExistInRange(any, any)).called(1);
  });

  test(
      "When call getTaskListFromData then call getTaskListFromData on provider and return fill list",
      () async {
    when(repository.getTaskListFromData(any))
        .thenAnswer((realInvocation) => Future.value([TaskItem.empty()]));
    var result = await usecase.getTaskListFromData(0);

    expect(result.length, 1);

    verify(repository.getTaskListFromData(any)).called(1);
  });

  test(
      "When call getTaskListFromData then call getTaskListFromData on provider and return empty list",
      () async {
    when(repository.getTaskListFromData(any)).thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.getTaskListFromData(0);

    expect(result.length, 0);

    verify(repository.getTaskListFromData(any)).called(1);
  });

  test("When call getAllTasks then call getAllTasks on provider and return fill list", () async {
    when(repository.getAllTasks()).thenAnswer((realInvocation) => Future.value([TaskItem.empty()]));
    var result = await usecase.getAllTasks();

    expect(result.length, 1);

    verify(repository.getAllTasks()).called(1);
  });

  test("When call getAllTasks then call getAllTasks on provider and return empty list", () async {
    when(repository.getAllTasks()).thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.getAllTasks();

    expect(result.length, 0);

    verify(repository.getAllTasks()).called(1);
  });

  test("When call getTaskByID then call getTaskByID on provider", () async {
    var sampleTask = TaskItem.empty();
    when(repository.getTaskByID(any)).thenAnswer((realInvocation) => Future.value(sampleTask));
    var result = await usecase.getTaskByID("");

    expect(result, sampleTask);

    verify(repository.getTaskByID(any)).called(1);
  });

  test("When call getTaskByID then call getTaskByID on provider and return null", () async {
    when(repository.getTaskByID(any)).thenAnswer((realInvocation) => Future.value(null));
    var result = await usecase.getTaskByID("");

    expect(result, null);

    verify(repository.getTaskByID(any)).called(1);
  });
}
