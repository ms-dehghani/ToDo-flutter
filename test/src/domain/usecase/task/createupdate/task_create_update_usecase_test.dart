import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/domain/repositories/task/createupdate/task_create_update_item_repository.dart';
import 'package:ToDo/src/domain/usecase/task/createupdate/task_create_update_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_create_update_usecase_test.mocks.dart';

@GenerateMocks([TaskCreateUpdateItemRepository])
void main() {
  late TaskCreateUpdateUseCase usecase;
  late MockTaskCreateUpdateItemRepository repository;

  setUpAll(() async {
    repository = MockTaskCreateUpdateItemRepository();
    usecase = TaskCreateUpdateUseCase(repository: repository);
  });

  test("When call createOrUpdateTask then call clear on provider", () async {
    var sampleTask = TaskItem.empty();
    when(repository.createOrUpdateTask(any))
        .thenAnswer((realInvocation) => Future.value(sampleTask));
    var result = await usecase.invoke(sampleTask);

    expect(result, sampleTask);

    verify(repository.createOrUpdateTask(any)).called(1);
  });
}
