import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/repositories/task/retrieve/item/task_retrieve_item_repository.dart';
import 'package:ToDo/src/domain/usecase/task/retrieve/item/task_retrieve_item_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_retrieve_item_usecase_test.mocks.dart';

@GenerateMocks([TaskRetrieveItemRepository])
void main() {
  late TaskRetrieveItemUseCase usecase;
  late MockTaskRetrieveItemRepository repository;

  setUpAll(() async {
    repository = MockTaskRetrieveItemRepository();
    usecase = TaskRetrieveItemUseCase(repository: repository);
  });

  test("When call getTaskByID then call getTaskByID on provider", () async {
    var sampleTask = TaskItem.empty();
    when(repository.getTaskByID(any))
        .thenAnswer((realInvocation) => Future.value(sampleTask));
    var result = await usecase.invoke("");

    expect(result, sampleTask);

    verify(repository.getTaskByID(any)).called(1);
  });

  test(
      "When call getTaskByID then call getTaskByID on provider and return null",
      () async {
    when(repository.getTaskByID(any))
        .thenAnswer((realInvocation) => Future.value(null));
    var result = await usecase.invoke("");

    expect(result, null);

    verify(repository.getTaskByID(any)).called(1);
  });
}
