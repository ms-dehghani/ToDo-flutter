import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/repositories/priority/priority_item_repository.dart';
import 'package:ToDo/src/domain/usecase/priority/priority_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'priority_usecase_test.mocks.dart';

@GenerateMocks([PriorityItemRepository])
void main() {
  late PriorityUseCase usecase;
  late MockPriorityItemRepository repository;

  setUpAll(() async {
    repository = MockPriorityItemRepository();
    usecase = PriorityUseCase(repository: repository);
  });

  test("When call clear then call clear on provider", () {
    when(repository.clear()).thenAnswer((realInvocation) => Future.value());
    usecase.clear();

    verify(repository.clear()).called(1);
  });

  test("When call getPriorities then call getPriorities on provider and return fill list",
      () async {
    when(repository.getPriorities())
        .thenAnswer((realInvocation) => Future.value([PriorityItem.empty()]));
    var result = await usecase.getPriorities();

    expect(result.length, 1);

    verify(repository.getPriorities()).called(1);
  });

  test("When call getPriorities then call getPriorities on provider and return empty list",
      () async {
    when(repository.getPriorities()).thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.getPriorities();

    expect(result.length, 0);

    verify(repository.getPriorities()).called(1);
  });

  test("When call getPriority then call getPriority on provider", () async {
    var samplePriority = PriorityItem.empty();
    when(repository.getPriority(any)).thenAnswer((realInvocation) => Future.value(samplePriority));
    var result = await usecase.getPriority("");

    expect(result, samplePriority);

    verify(repository.getPriority(any)).called(1);
  });

  test("When call getPriority then call getPriority on provider and return null", () async {
    when(repository.getPriority(any)).thenAnswer((realInvocation) => Future.value(null));
    var result = await usecase.getPriority("");

    expect(result, null);

    verify(repository.getPriority(any)).called(1);
  });

  test("When call deletePriority then call deletePriority on provider and return true", () async {
    when(repository.deletePriority(any)).thenAnswer((realInvocation) => Future.value(true));
    var result = await usecase.deletePriority("");

    expect(result, true);

    verify(repository.deletePriority(any)).called(1);
  });

  test("When call deletePriority then call deletePriority on provider and return false", () async {
    when(repository.deletePriority(any)).thenAnswer((realInvocation) => Future.value(false));
    var result = await usecase.deletePriority("");

    expect(result, false);

    verify(repository.deletePriority(any)).called(1);
  });

  test("When call createOrUpdatePriority then call clear on provider", () async {
    var samplePriority = PriorityItem.empty();
    when(repository.createOrUpdatePriority(any))
        .thenAnswer((realInvocation) => Future.value(samplePriority));
    var result = await usecase.createOrUpdatePriority(samplePriority);

    expect(result, samplePriority);

    verify(repository.createOrUpdatePriority(any)).called(1);
  });
}
