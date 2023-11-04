import 'package:ToDo/src/data/datasource/category/category_data_provider.dart';
import 'package:ToDo/src/data/repositories/category/category_repository.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_repository_test.mocks.dart';

@GenerateMocks([CategoryDataProvider])
void main() {
  late CategoryRepository repository;
  late MockCategoryDataProvider dataProvider;

  setUpAll(() async {
    dataProvider = MockCategoryDataProvider();
    repository = CategoryRepository(dataProvider, null);
  });

  test("When call clear then call clear on provider", () {
    when(dataProvider.clear()).thenAnswer((realInvocation) => Future.value());
    repository.clear();

    verify(dataProvider.clear()).called(1);
  });

  test("When call getCategories then call getCategories on provider and return fill list",
      () async {
    when(dataProvider.getCategories())
        .thenAnswer((realInvocation) => Future.value([CategoryItem.empty()]));
    var result = await repository.getCategories();

    expect(result.length, 1);

    verify(dataProvider.getCategories()).called(1);
  });

  test("When call getCategories then call getCategories on provider and return empty list",
      () async {
    when(dataProvider.getCategories()).thenAnswer((realInvocation) => Future.value([]));
    var result = await repository.getCategories();

    expect(result.length, 0);

    verify(dataProvider.getCategories()).called(1);
  });

  test("When call getCategory then call getCategory on provider", () async {
    var sampleCategory = CategoryItem.empty();
    when(dataProvider.getCategory(any))
        .thenAnswer((realInvocation) => Future.value(sampleCategory));
    var result = await repository.getCategory("");

    expect(result, sampleCategory);

    verify(dataProvider.getCategory(any)).called(1);
  });

  test("When call getCategory then call getCategory on provider and return null", () async {
    when(dataProvider.getCategory(any)).thenAnswer((realInvocation) => Future.value(null));
    var result = await repository.getCategory("");

    expect(result, null);

    verify(dataProvider.getCategory(any)).called(1);
  });

  test("When call deleteCategory then call deleteCategory on provider and return true", () async {
    when(dataProvider.deleteCategory(any)).thenAnswer((realInvocation) => Future.value(true));
    var result = await repository.deleteCategory("");

    expect(result, true);

    verify(dataProvider.deleteCategory(any)).called(1);
  });

  test("When call deleteCategory then call deleteCategory on provider and return false", () async {
    when(dataProvider.deleteCategory(any)).thenAnswer((realInvocation) => Future.value(false));
    var result = await repository.deleteCategory("");

    expect(result, false);

    verify(dataProvider.deleteCategory(any)).called(1);
  });

  test("When call createOrUpdateCategory then call clear on provider", () async {
    var sampleCategory = CategoryItem.empty();
    when(dataProvider.createOrUpdateCategory(any))
        .thenAnswer((realInvocation) => Future.value(sampleCategory));
    var result = await repository.createOrUpdateCategory(sampleCategory);

    expect(result, sampleCategory);

    verify(dataProvider.createOrUpdateCategory(any)).called(1);
  });
}
