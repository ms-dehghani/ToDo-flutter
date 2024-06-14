import 'package:ToDo/src/domain/repositories/category/retrieve/all/category_retrieve_all_items_repository.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/all/category_retrieve_all_items_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_retrieve_all_items_usecase_test.mocks.dart';

@GenerateMocks([CategoryRetrieveAllItemsRepository])
void main() {
  late CategoryRetrieveAllItemsUseCase usecase;
  late MockCategoryRetrieveAllItemsRepository repository;

  setUpAll(() async {
    repository = MockCategoryRetrieveAllItemsRepository();
    usecase = CategoryRetrieveAllItemsUseCase(repository: repository);
  });

  test(
      "When call getCategories then call getCategories on provider and return empty list",
      () async {
    when(repository.getCategories())
        .thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.invoke();

    expect(result.length, 0);

    verify(repository.getCategories()).called(1);
  });
}
