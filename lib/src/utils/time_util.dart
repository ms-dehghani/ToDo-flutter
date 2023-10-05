

import 'package:shamsi_date/shamsi_date.dart';

String timeToText(int timestamp){
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var jalali = Jalali.fromDateTime(date);
  return "${jalali.day}/${jalali.month}/${jalali.year}";
}