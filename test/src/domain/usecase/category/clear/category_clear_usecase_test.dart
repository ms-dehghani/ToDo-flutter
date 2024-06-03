import 'package:ToDo/src/domain/repositories/category/clear/category_clear_items_repository.dart';
import 'package:ToDo/src/domain/usecase/category/clear/category_clear_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_clear_usecase_test.mocks.dart';

@GenerateMocks([CategoryClearItemsRepository])
void main() {
  late CategoryClearUseCase usecase;
  late MockCategoryClearItemsRepository repository;

  setUpAll(() async {
    repository = MockCategoryClearItemsRepository();
    usecase = CategoryClearUseCase(repository: repository);
  });

  test("When call clear then call clear on provider", () {
    when(repository.clear()).thenAnswer((realInvocation) => Future.value());
    usecase.invoke();

    verify(repository.clear()).called(1);
  });
}
