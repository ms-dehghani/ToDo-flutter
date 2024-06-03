import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/repositories/priority/create/priority_create_item_repository.dart';
import 'package:ToDo/src/domain/usecase/priority/create/priority_create_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'priority_create_usecase_test.mocks.dart';

@GenerateMocks([PriorityCreateItemRepository])
void main() {
  late PriorityCreateUseCase usecase;
  late MockPriorityCreateItemRepository repository;

  setUpAll(() async {
    repository = MockPriorityCreateItemRepository();
    usecase = PriorityCreateUseCase(repository: repository);
  });

  test("When call createOrUpdatePriority then call clear on provider",
      () async {
    var samplePriority = PriorityItem.empty();
    when(repository.createOrUpdatePriority(any))
        .thenAnswer((realInvocation) => Future.value(samplePriority));
    var result = await usecase.invoke(samplePriority);

    expect(result, samplePriority);

    verify(repository.createOrUpdatePriority(any)).called(1);
  });
}
