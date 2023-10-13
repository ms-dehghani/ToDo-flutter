import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/base/parent_page_data.dart';

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
