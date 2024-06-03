import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/category/create_update/bloc/category_create_update_bloc.dart';
import 'package:ToDo/src/app/logic/category/create_update/bloc/category_create_update_event.dart';
import 'package:ToDo/src/app/logic/category/create_update/bloc/category_create_update_page_data.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/usecase/category/createupdate/category_create_or_update_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_create_update_bloc_test.mocks.dart';

@GenerateMocks([CategoryCreateOrUpdateUseCase])
void main() {
  late CategoryCreateOrUpdateBloc createOrUpdateBloc;
  late MockCategoryCreateOrUpdateUseCase categoryUseCase;

  setUp(() {
    EquatableConfig.stringify = true;
    categoryUseCase = MockCategoryCreateOrUpdateUseCase();
    createOrUpdateBloc =
        CategoryCreateOrUpdateBloc(categoryUseCase: categoryUseCase);
  });

  blocTest<CategoryCreateOrUpdateBloc, CategoryCreateUpdateBlocPageData>(
    "Given empty category then must return failure",
    build: () => createOrUpdateBloc,
    act: (bloc) =>
        bloc.add(CategoryCreateOrUpdateResultEvent(CategoryItem.empty())),
    expect: () {
      return [
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.loading, item: null),
        CategoryCreateUpdateBlocPageData(status: PageStatus.failure, item: null)
      ];
    },
  );

  group("Add and update category", () {
    CategoryItem categoryItem = CategoryItem("_id", "_title");
    CategoryItem updatedCategoryItem = CategoryItem("_id", "_title2");

    blocTest<CategoryCreateOrUpdateBloc, CategoryCreateUpdateBlocPageData>(
      "Given category then must add and return success",
      build: () {
        when(categoryUseCase.invoke(any)).thenAnswer((realInvocation) {
          return Future.value(realInvocation.positionalArguments[0]);
        });
        return createOrUpdateBloc;
      },
      act: (bloc) => bloc.add(CategoryCreateOrUpdateResultEvent(categoryItem)),
      expect: () => <CategoryCreateUpdateBlocPageData>[
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.loading, item: null),
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.success, item: categoryItem)
      ],
    );

    blocTest<CategoryCreateOrUpdateBloc, CategoryCreateUpdateBlocPageData>(
      "Given exist category then must update and return success",
      build: () {
        when(categoryUseCase.invoke(any)).thenAnswer((realInvocation) {
          return Future.value(realInvocation.positionalArguments[0]);
        });
        return createOrUpdateBloc;
      },
      act: (bloc) {
        bloc.add(CategoryCreateOrUpdateResultEvent(categoryItem));
        bloc.add(CategoryCreateOrUpdateResultEvent(updatedCategoryItem));
      },
      expect: () => <CategoryCreateUpdateBlocPageData>[
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.loading, item: null),
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.success, item: categoryItem),
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.loading, item: categoryItem),
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.success, item: updatedCategoryItem),
      ],
    );
  });

  group("Update ui", () {
    blocTest<CategoryCreateOrUpdateBloc, CategoryCreateUpdateBlocPageData>(
      "Call once function",
      build: () {
        return createOrUpdateBloc;
      },
      act: (bloc) {
        bloc.add(UpdateUI());
      },
      expect: () => <CategoryCreateUpdateBlocPageData>[
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.loading, item: null),
      ],
    );

    blocTest<CategoryCreateOrUpdateBloc, CategoryCreateUpdateBlocPageData>(
      "Call twice function",
      build: () {
        return createOrUpdateBloc;
      },
      act: (bloc) {
        bloc.add(UpdateUI());
        bloc.add(UpdateUI());
      },
      expect: () => <CategoryCreateUpdateBlocPageData>[
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.loading, item: null),
        CategoryCreateUpdateBlocPageData(
            status: PageStatus.initial, item: null),
      ],
    );
  });

  tearDown(() {
    createOrUpdateBloc.close();
  });
}
