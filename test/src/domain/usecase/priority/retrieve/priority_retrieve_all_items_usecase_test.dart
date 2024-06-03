import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/repositories/priority/retrieve/priority_retrieve_all_items_repository.dart';
import 'package:ToDo/src/domain/usecase/priority/retrieve/priority_retrieve_all_items_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'priority_retrieve_all_items_usecase_test.mocks.dart';

@GenerateMocks([PriorityRetrieveAllItemsRepository])
void main() {
  late PriorityRetrieveAllItemsUseCase usecase;
  late MockPriorityRetrieveAllItemsRepository repository;

  setUpAll(() async {
    repository = MockPriorityRetrieveAllItemsRepository();
    usecase = PriorityRetrieveAllItemsUseCase(repository: repository);
  });

  test(
      "When call getPriorities then call getPriorities on provider and return fill list",
      () async {
    when(repository.getPriorities())
        .thenAnswer((realInvocation) => Future.value([PriorityItem.empty()]));
    var result = await usecase.invoke();

    expect(result.length, 1);

    verify(repository.getPriorities()).called(1);
  });

  test(
      "When call getPriorities then call getPriorities on provider and return empty list",
      () async {
    when(repository.getPriorities())
        .thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.invoke();

    expect(result.length, 0);

    verify(repository.getPriorities()).called(1);
  });
}
