import 'package:ToDo/src/domain/repositories/category/delete/category_delete_item_repository.dart';
import 'package:ToDo/src/domain/usecase/category/delete/category_delete_item_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_delete_usecase_test.mocks.dart';

@GenerateMocks([CategoryDeleteItemRepository])
void main() {
  late CategoryDeleteUseCase usecase;
  late MockCategoryDeleteItemRepository repository;

  setUpAll(() async {
    repository = MockCategoryDeleteItemRepository();
    usecase = CategoryDeleteUseCase(repository: repository);
  });

  test(
      "When call deleteCategory then call deleteCategory on provider and return true",
      () async {
    when(repository.deleteCategory(any))
        .thenAnswer((realInvocation) => Future.value(true));
    var result = await usecase.invoke("");

    expect(result, true);

    verify(repository.deleteCategory(any)).called(1);
  });

  test(
      "When call deleteCategory then call deleteCategory on provider and return false",
      () async {
    when(repository.deleteCategory(any))
        .thenAnswer((realInvocation) => Future.value(false));
    var result = await usecase.invoke("");

    expect(result, false);

    verify(repository.deleteCategory(any)).called(1);
  });
}
