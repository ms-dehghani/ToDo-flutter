import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/category/get/bloc/category_get_bloc.dart';
import 'package:ToDo/src/app/logic/category/get/bloc/category_get_event.dart';
import 'package:ToDo/src/app/logic/category/get/bloc/category_get_page_data.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/all/category_retrieve_all_items_usecase.dart';
import 'package:ToDo/src/domain/usecase/category/retrieve/item/category_retrieve_item_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_get_bloc_test.mocks.dart';

@GenerateMocks([CategoryRetrieveItemUseCase, CategoryRetrieveAllItemsUseCase])
void main() {
  late CategoryGetBloc getBloc;
  late MockCategoryRetrieveAllItemsUseCase useCase;

  setUp(() {
    EquatableConfig.stringify = true;
    useCase = MockCategoryRetrieveAllItemsUseCase();
    getBloc = CategoryGetBloc(categoryAllItemsUseCase: useCase);
  });

  blocTest<CategoryGetBloc, CategoryGetBlocPageData>(
    "Get empty category list",
    build: () {
      when(useCase.invoke()).thenAnswer((realInvocation) {
        return Future.value([]);
      });
      return getBloc;
    },
    act: (bloc) => bloc.add(GetAllCategoryEvent()),
    expect: () {
      return [
        CategoryGetBlocPageData(status: PageStatus.loading),
        CategoryGetBlocPageData(status: PageStatus.success)
      ];
    },
  );

  blocTest<CategoryGetBloc, CategoryGetBlocPageData>(
    "Get single item in category list",
    build: () {
      when(useCase.invoke()).thenAnswer((realInvocation) {
        return Future.value([CategoryItem.empty()]);
      });
      return getBloc;
    },
    act: (bloc) => bloc.add(GetAllCategoryEvent()),
    expect: () {
      return [
        CategoryGetBlocPageData(status: PageStatus.loading),
        CategoryGetBlocPageData(
            status: PageStatus.success, categoryList: [CategoryItem.empty()])
      ];
    },
  );

  tearDown(() {
    getBloc.close();
  });
}
