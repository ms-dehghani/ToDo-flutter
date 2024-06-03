import 'package:ToDo/src/domain/repositories/task/existence/task_check_existence_repository.dart';
import 'package:ToDo/src/domain/usecase/task/existence/task_check_existence_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_check_existance_usecase_test.mocks.dart';

@GenerateMocks([TaskCheckExistenceRepository])
void main() {
  late TaskCheckExistenceUseCase usecase;
  late MockTaskCheckExistenceRepository repository;

  setUpAll(() async {
    repository = MockTaskCheckExistenceRepository();
    usecase = TaskCheckExistenceUseCase(repository: repository);
  });

  test(
      "When call isAnyTaskExistInRange then call isAnyTaskExistInRange on provider and return true",
      () async {
    when(repository.isAnyTaskExistInRange(any, any))
        .thenAnswer((realInvocation) => Future.value({1: false, 2: true}));
    var result = await usecase.invoke(0, 0);

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
    var result = await usecase.invoke(0, 0);

    expect(result.length, 0);

    verify(repository.isAnyTaskExistInRange(any, any)).called(1);
  });
}
