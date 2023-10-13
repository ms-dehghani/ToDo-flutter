import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/base/parent_page_data.dart';
import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';

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
