import 'package:kardone/src/app/logic/base/parent_page_data.dart';

import '../../../base/page_status.dart';

class TaskDeleteBlocPageData extends ParentPageData {
  TaskDeleteBlocPageData({required PageStatus status}) : super(pageStatus: status);

  TaskDeleteBlocPageData copyWith({PageStatus? status}) {
    return TaskDeleteBlocPageData(
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus];

}
