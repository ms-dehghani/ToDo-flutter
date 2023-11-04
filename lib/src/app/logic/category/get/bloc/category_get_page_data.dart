import 'package:ToDo/src/app/logic/base/parent_page_data.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';

import '../../../base/page_status.dart';

class CategoryGetBlocPageData extends ParentPageData {
  List<CategoryItem> categoryList;

  CategoryGetBlocPageData({this.categoryList = const [], required PageStatus status})
      : super(pageStatus: status);

  CategoryGetBlocPageData copyWith({
    PageStatus? status,
    List<CategoryItem>? categoryList,
  }) {
    return CategoryGetBlocPageData(
      categoryList: categoryList ?? this.categoryList,
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus, categoryList];
}
