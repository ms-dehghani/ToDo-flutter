import 'package:ToDo/src/domain/repositories/task/delete/task_delete_item_repository.dart';
import 'package:ToDo/src/domain/usecase/task/delete/task_delete_item_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_delete_itemusecase_test.mocks.dart';

@GenerateMocks([TaskDeleteItemRepository])
void main() {
  late TaskDeleteItemUseCase usecase;
  late MockTaskDeleteItemRepository repository;

  setUpAll(() async {
    repository = MockTaskDeleteItemRepository();
    usecase = TaskDeleteItemUseCase(repository: repository);
  });

  test("When call deleteTask then call deleteTask on provider and return true",
      () async {
    when(repository.deleteTask(any))
        .thenAnswer((realInvocation) => Future.value(true));
    var result = await usecase.invoke("");

    expect(result, true);

    verify(repository.deleteTask(any)).called(1);
  });

  test("When call deleteTask then call deleteTask on provider and return false",
      () async {
    when(repository.deleteTask(any))
        .thenAnswer((realInvocation) => Future.value(false));
    var result = await usecase.invoke("");

    expect(result, false);

    verify(repository.deleteTask(any)).called(1);
  });
}
