import 'package:kardone/res/texts.dart';
import 'package:kardone/src/utils/extentions/translates_string_extentions.dart';
import 'package:kardone/translations.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'direction_util.dart';

String timeToText(int timestamp, {bool withDay = true}) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  if (isRTL()) {
    var jalali = Jalali.fromDateTime(date);
    return "${jalali.year} ${Texts.monthName[jalali.month - 1].translate} ${withDay ? jalali.day : ""}";
  } else {
    return "${date.year} ${Texts.monthName[date.month - 1].translate} ${withDay ? date.day : ""}";
  }
}

String dayOfWeek(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return Texts.weekName[date.weekday - 1].translate;
}

String dayOfMonth(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var jalali = Jalali.fromDateTime(date);
  return "${jalali.day}";
}
