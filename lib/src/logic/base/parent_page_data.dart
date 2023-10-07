
import 'package:equatable/equatable.dart';
import 'package:kardone/src/logic/base/page_status.dart';

abstract class ParentPageData extends Equatable{
  PageStatus pageStatus;

  ParentPageData({required this.pageStatus});

}