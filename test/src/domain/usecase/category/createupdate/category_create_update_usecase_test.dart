import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/repositories/category/createupdate/category_create_or_update_item_repository.dart';
import 'package:ToDo/src/domain/usecase/category/createupdate/category_create_or_update_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_create_update_usecase_test.mocks.dart';

@GenerateMocks([CategoryCreateOrUpdateItemRepository])
void main() {
  late CategoryCreateOrUpdateUseCase usecase;
  late MockCategoryCreateOrUpdateItemRepository repository;

  setUpAll(() async {
    repository = MockCategoryCreateOrUpdateItemRepository();
    usecase = CategoryCreateOrUpdateUseCase(repository: repository);
  });

  test("When call createOrUpdateCategory then call clear on provider",
      () async {
    var sampleCategory = CategoryItem.empty();
    when(repository.createOrUpdateCategory(any))
        .thenAnswer((realInvocation) => Future.value(sampleCategory));
    var result = await usecase.invoke(sampleCategory);

    expect(result, sampleCategory);

    verify(repository.createOrUpdateCategory(any)).called(1);
  });
}
