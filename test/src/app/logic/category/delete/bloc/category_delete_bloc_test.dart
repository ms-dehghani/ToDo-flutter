import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/category/delete/bloc/category_delete_bloc.dart';
import 'package:ToDo/src/app/logic/category/delete/bloc/category_delete_event.dart';
import 'package:ToDo/src/app/logic/category/delete/bloc/category_delete_page_data.dart';
import 'package:ToDo/src/domain/usecase/category/delete/category_delete_item_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_delete_bloc_test.mocks.dart';

@GenerateMocks([CategoryDeleteUseCase])
void main() {
  late CategoryDeleteBloc deleteBloc;
  late MockCategoryDeleteUseCase categoryUseCase;

  setUp(() {
    EquatableConfig.stringify = true;
    categoryUseCase = MockCategoryDeleteUseCase();
    deleteBloc = CategoryDeleteBloc(categoryUseCase: categoryUseCase);
  });

  group("Delete category", () {
    blocTest<CategoryDeleteBloc, CategoryDeleteBlocPageData>(
      "Given id then must return failure",
      build: () {
        when(categoryUseCase.invoke(any)).thenAnswer((realInvocation) {
          return Future.value(false);
        });
        return deleteBloc;
      },
      act: (bloc) => bloc.add(CategoryDeleteEvent(id: "")),
      expect: () => <CategoryDeleteBlocPageData>[
        CategoryDeleteBlocPageData(status: PageStatus.loading),
        CategoryDeleteBlocPageData(status: PageStatus.failure)
      ],
    );

    blocTest<CategoryDeleteBloc, CategoryDeleteBlocPageData>(
      "Given id then must return success",
      build: () {
        when(categoryUseCase.invoke(any)).thenAnswer((realInvocation) {
          return Future.value(true);
        });
        return deleteBloc;
      },
      act: (bloc) => bloc.add(CategoryDeleteEvent(id: "")),
      expect: () => <CategoryDeleteBlocPageData>[
        CategoryDeleteBlocPageData(status: PageStatus.loading),
        CategoryDeleteBlocPageData(status: PageStatus.success)
      ],
    );
  });

  tearDown(() {
    deleteBloc.close();
  });
}
