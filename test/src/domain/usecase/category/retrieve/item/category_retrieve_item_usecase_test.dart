import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/repositories/category/retrieve/item/category_retrieve_item_repository.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/item/category_retrieve_item_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_retrieve_item_usecase_test.mocks.dart';

@GenerateMocks([CategoryRetrieveItemRepository])
void main() {
  late CategoryRetrieveItemUseCase usecase;
  late MockCategoryRetrieveItemRepository repository;

  setUpAll(() async {
    repository = MockCategoryRetrieveItemRepository();
    usecase = CategoryRetrieveItemUseCase(repository: repository);
  });

  test("When call getCategory then call getCategory on provider", () async {
    var sampleCategory = CategoryItem.empty();
    when(repository.getCategory(any))
        .thenAnswer((realInvocation) => Future.value(sampleCategory));
    var result = await usecase.invoke("");

    expect(result, sampleCategory);

    verify(repository.getCategory(any)).called(1);
  });

  test(
      "When call getCategory then call getCategory on provider and return null",
      () async {
    when(repository.getCategory(any))
        .thenAnswer((realInvocation) => Future.value(null));
    var result = await usecase.invoke("");

    expect(result, null);

    verify(repository.getCategory(any)).called(1);
  });
}
