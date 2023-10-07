import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/base/parent_page_data.dart';

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
