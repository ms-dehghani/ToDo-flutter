import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/repositories/task/retrieve/daylist/task_retrieve_day_list_items_repository.dart';
import 'package:ToDo/src/domain/usecase/task/retrieve/daylist/task_retrieve_day_list_items_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_retrieve_day_list_items_usecase_test.mocks.dart';

@GenerateMocks([TaskRetrieveDayListItemsRepository])
void main() {
  late TaskRetrieveDayListItemsUseCase usecase;
  late MockTaskRetrieveDayListItemsRepository repository;

  setUpAll(() async {
    repository = MockTaskRetrieveDayListItemsRepository();
    usecase = TaskRetrieveDayListItemsUseCase(repository: repository);
  });

  test(
      "When call getTaskListFromData then call getTaskListFromData on provider and return fill list",
      () async {
    when(repository.getTaskListFromData(any))
        .thenAnswer((realInvocation) => Future.value([TaskItem.empty()]));
    var result = await usecase.invoke(0);

    expect(result.length, 1);

    verify(repository.getTaskListFromData(any)).called(1);
  });

  test(
      "When call getTaskListFromData then call getTaskListFromData on provider and return empty list",
      () async {
    when(repository.getTaskListFromData(any))
        .thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.invoke(0);

    expect(result.length, 0);

    verify(repository.getTaskListFromData(any)).called(1);
  });
}
