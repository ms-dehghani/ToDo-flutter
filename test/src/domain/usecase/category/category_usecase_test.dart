import 'package:ToDo/src/domain/repositories/category/category_item_repository.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/usecase/category/category_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_usecase_test.mocks.dart';

@GenerateMocks([CategoryItemRepository])
void main() {
  late CategoryUseCase usecase;
  late MockCategoryItemRepository repository;

  setUpAll(() async {
    repository = MockCategoryItemRepository();
    usecase = CategoryUseCase(repository: repository);
  });

  test("When call clear then call clear on provider", () {
    when(repository.clear()).thenAnswer((realInvocation) => Future.value());
    usecase.clear();

    verify(repository.clear()).called(1);
  });

  test("When call getCategories then call getCategories on provider and return fill list",
      () async {
    when(repository.getCategories())
        .thenAnswer((realInvocation) => Future.value([CategoryItem.empty()]));
    var result = await usecase.getCategories();

    expect(result.length, 1);

    verify(repository.getCategories()).called(1);
  });

  test("When call getCategories then call getCategories on provider and return empty list",
      () async {
    when(repository.getCategories()).thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.getCategories();

    expect(result.length, 0);

    verify(repository.getCategories()).called(1);
  });

  test("When call getCategory then call getCategory on provider", () async {
    var sampleCategory = CategoryItem.empty();
    when(repository.getCategory(any)).thenAnswer((realInvocation) => Future.value(sampleCategory));
    var result = await usecase.getCategory("");

    expect(result, sampleCategory);

    verify(repository.getCategory(any)).called(1);
  });

  test("When call getCategory then call getCategory on provider and return null", () async {
    when(repository.getCategory(any)).thenAnswer((realInvocation) => Future.value(null));
    var result = await usecase.getCategory("");

    expect(result, null);

    verify(repository.getCategory(any)).called(1);
  });

  test("When call deleteCategory then call deleteCategory on provider and return true", () async {
    when(repository.deleteCategory(any)).thenAnswer((realInvocation) => Future.value(true));
    var result = await usecase.deleteCategory("");

    expect(result, true);

    verify(repository.deleteCategory(any)).called(1);
  });

  test("When call deleteCategory then call deleteCategory on provider and return false", () async {
    when(repository.deleteCategory(any)).thenAnswer((realInvocation) => Future.value(false));
    var result = await usecase.deleteCategory("");

    expect(result, false);

    verify(repository.deleteCategory(any)).called(1);
  });

  test("When call createOrUpdateCategory then call clear on provider", () async {
    var sampleCategory = CategoryItem.empty();
    when(repository.createOrUpdateCategory(any))
        .thenAnswer((realInvocation) => Future.value(sampleCategory));
    var result = await usecase.createOrUpdateCategory(sampleCategory);

    expect(result, sampleCategory);

    verify(repository.createOrUpdateCategory(any)).called(1);
  });
}
