
import 'package:equatable/equatable.dart';
import 'page_status.dart';

abstract class ParentPageData extends Equatable{
  PageStatus pageStatus;

  ParentPageData({required this.pageStatus});

}