import 'package:kardone/src/app/logic/base/parent_page_data.dart';

import '../../../base/page_status.dart';

class CategoryDeleteBlocPageData extends ParentPageData {
  CategoryDeleteBlocPageData({required PageStatus status}) : super(pageStatus: status);

  CategoryDeleteBlocPageData copyWith({PageStatus? status}) {
    return CategoryDeleteBlocPageData(
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus];

}
