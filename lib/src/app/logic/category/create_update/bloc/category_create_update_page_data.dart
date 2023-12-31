import 'package:ToDo/src/app/logic/base/parent_page_data.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';

import '../../../base/page_status.dart';

class CategoryCreateUpdateBlocPageData extends ParentPageData {
  CategoryItem? item;

  CategoryCreateUpdateBlocPageData({required this.item, required PageStatus status})
      : super(pageStatus: status);

  CategoryCreateUpdateBlocPageData copyWith({
    CategoryItem? item,
    PageStatus? status,
  }) {
    return CategoryCreateUpdateBlocPageData(
      item: item ?? this.item,
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus, item];
}
