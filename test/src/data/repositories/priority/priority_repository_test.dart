import 'package:ToDo/src/data/datasource/priority/priority_data_provider.dart';
import 'package:ToDo/src/data/repositories/priority/priority_repository.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'priority_repository_test.mocks.dart';

@GenerateMocks([PriorityDataProvider])
void main() {
  late PriorityRepository repository;
  late MockPriorityDataProvider dataProvider;

  setUpAll(() async {
    dataProvider = MockPriorityDataProvider();
    repository = PriorityRepository(dataProvider, null);
  });

  test("When call clear then call clear on provider", () {
    when(dataProvider.clear()).thenAnswer((realInvocation) => Future.value());
    repository.clear();

    verify(dataProvider.clear()).called(1);
  });

  test("When call getPriorities then call getPriorities on provider and return fill list",
      () async {
    when(dataProvider.getPriorities())
        .thenAnswer((realInvocation) => Future.value([PriorityItem.empty()]));
    var result = await repository.getPriorities();

    expect(result.length, 1);

    verify(dataProvider.getPriorities()).called(1);
  });

  test("When call getPriorities then call getPriorities on provider and return empty list",
      () async {
    when(dataProvider.getPriorities()).thenAnswer((realInvocation) => Future.value([]));
    var result = await repository.getPriorities();

    expect(result.length, 0);

    verify(dataProvider.getPriorities()).called(1);
  });

  test("When call getPriority then call getPriority on provider", () async {
    var samplePriority = PriorityItem.empty();
    when(dataProvider.getPriority(any))
        .thenAnswer((realInvocation) => Future.value(samplePriority));
    var result = await repository.getPriority("");

    expect(result, samplePriority);

    verify(dataProvider.getPriority(any)).called(1);
  });

  test("When call getPriority then call getPriority on provider and return null", () async {
    when(dataProvider.getPriority(any))
        .thenAnswer((realInvocation) => Future.value(null));
    var result = await repository.getPriority("");

    expect(result, null);

    verify(dataProvider.getPriority(any)).called(1);
  });

  test("When call deletePriority then call deletePriority on provider and return true", () async {
    when(dataProvider.deletePriority(any)).thenAnswer((realInvocation) => Future.value(true));
    var result = await repository.deletePriority("");

    expect(result, true);

    verify(dataProvider.deletePriority(any)).called(1);
  });

  test("When call deletePriority then call deletePriority on provider and return false", () async {
    when(dataProvider.deletePriority(any)).thenAnswer((realInvocation) => Future.value(false));
    var result = await repository.deletePriority("");

    expect(result, false);

    verify(dataProvider.deletePriority(any)).called(1);
  });

  test("When call createOrUpdatePriority then call clear on provider", () async {
    var samplePriority = PriorityItem.empty();
    when(dataProvider.createOrUpdatePriority(any))
        .thenAnswer((realInvocation) => Future.value(samplePriority));
    var result = await repository.createOrUpdatePriority(samplePriority);

    expect(result, samplePriority);

    verify(dataProvider.createOrUpdatePriority(any)).called(1);
  });
}
