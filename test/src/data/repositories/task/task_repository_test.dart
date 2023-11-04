import 'package:ToDo/src/data/datasource/task/task_data_provider.dart';
import 'package:ToDo/src/data/repositories/task/task_repository.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([TaskDataProvider])
void main() {
  late TaskRepository repository;
  late MockTaskDataProvider dataProvider;

  setUpAll(() async {
    dataProvider = MockTaskDataProvider();
    repository = TaskRepository(dataProvider, null);
  });

  test("When call clear then call clear on provider", () {
    when(dataProvider.clear()).thenAnswer((realInvocation) => Future.value());
    repository.clear();

    verify(dataProvider.clear()).called(1);
  });

  test("When call deleteTask then call deleteTask on provider and return true", () async {
    when(dataProvider.deleteTask(any)).thenAnswer((realInvocation) => Future.value(true));
    var result = await repository.deleteTask("");

    expect(result, true);

    verify(dataProvider.deleteTask(any)).called(1);
  });

  test("When call deleteTask then call deleteTask on provider and return false", () async {
    when(dataProvider.deleteTask(any)).thenAnswer((realInvocation) => Future.value(false));
    var result = await repository.deleteTask("");

    expect(result, false);

    verify(dataProvider.deleteTask(any)).called(1);
  });

  test("When call createOrUpdateTask then call clear on provider", () async {
    var sampleTask = TaskItem.empty();
    when(dataProvider.createOrUpdateTask(any))
        .thenAnswer((realInvocation) => Future.value(sampleTask));
    var result = await repository.createOrUpdateTask(sampleTask);

    expect(result, sampleTask);

    verify(dataProvider.createOrUpdateTask(any)).called(1);
  });

  test("When call isAnyTaskExistInDate then call isAnyTaskExistInDate on provider and return true",
      () async {
    when(dataProvider.isAnyTaskExistInDate(any)).thenAnswer((realInvocation) => Future.value(true));
    var result = await repository.isAnyTaskExistInDate(0);

    expect(result, true);

    verify(dataProvider.isAnyTaskExistInDate(any)).called(1);
  });

  test("When call isAnyTaskExistInDate then call isAnyTaskExistInDate on provider and return false",
      () async {
    when(dataProvider.isAnyTaskExistInDate(any))
        .thenAnswer((realInvocation) => Future.value(false));
    var result = await repository.isAnyTaskExistInDate(0);

    expect(result, false);

    verify(dataProvider.isAnyTaskExistInDate(any)).called(1);
  });

  test(
      "When call isAnyTaskExistInRange then call isAnyTaskExistInRange on provider and return true",
      () async {
    when(dataProvider.isAnyTaskExistInRange(any, any))
        .thenAnswer((realInvocation) => Future.value({1: false, 2: true}));
    var result = await repository.isAnyTaskExistInRange(0, 0);

    expect(result.length, 2);
    expect(result[1], false);
    expect(result[2], true);

    verify(dataProvider.isAnyTaskExistInRange(any, any)).called(1);
  });

  test(
      "When call isAnyTaskExistInRange then call isAnyTaskExistInRange on provider and return "
      "empty", () async {
    when(dataProvider.isAnyTaskExistInRange(any, any))
        .thenAnswer((realInvocation) => Future.value(<int, bool>{}));
    var result = await repository.isAnyTaskExistInRange(0, 0);

    expect(result.length, 0);

    verify(dataProvider.isAnyTaskExistInRange(any, any)).called(1);
  });

  test(
      "When call getTaskListFromData then call getTaskListFromData on provider and return fill list",
      () async {
    when(dataProvider.getTaskListFromData(any))
        .thenAnswer((realInvocation) => Future.value([TaskItem.empty()]));
    var result = await repository.getTaskListFromData(0);

    expect(result.length, 1);

    verify(dataProvider.getTaskListFromData(any)).called(1);
  });

  test(
      "When call getTaskListFromData then call getTaskListFromData on provider and return empty list",
      () async {
    when(dataProvider.getTaskListFromData(any)).thenAnswer((realInvocation) => Future.value([]));
    var result = await repository.getTaskListFromData(0);

    expect(result.length, 0);

    verify(dataProvider.getTaskListFromData(any)).called(1);
  });

  test("When call getAllTasks then call getAllTasks on provider and return fill list", () async {
    when(dataProvider.getAllTasks())
        .thenAnswer((realInvocation) => Future.value([TaskItem.empty()]));
    var result = await repository.getAllTasks();

    expect(result.length, 1);

    verify(dataProvider.getAllTasks()).called(1);
  });

  test("When call getAllTasks then call getAllTasks on provider and return empty list", () async {
    when(dataProvider.getAllTasks()).thenAnswer((realInvocation) => Future.value([]));
    var result = await repository.getAllTasks();

    expect(result.length, 0);

    verify(dataProvider.getAllTasks()).called(1);
  });

  test("When call getTaskByID then call getTaskByID on provider", () async {
    var sampleTask = TaskItem.empty();
    when(dataProvider.getTaskByID(any)).thenAnswer((realInvocation) => Future.value(sampleTask));
    var result = await repository.getTaskByID("");

    expect(result, sampleTask);

    verify(dataProvider.getTaskByID(any)).called(1);
  });

  test("When call getTaskByID then call getTaskByID on provider and return null", () async {
    when(dataProvider.getTaskByID(any)).thenAnswer((realInvocation) => Future.value(null));
    var result = await repository.getTaskByID("");

    expect(result, null);

    verify(dataProvider.getTaskByID(any)).called(1);
  });
}
