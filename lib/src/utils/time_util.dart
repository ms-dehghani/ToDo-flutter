import 'package:ToDo/res/string/texts.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'direction_util.dart';

String timeToText(int timestamp, {bool withDay = true}) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  if (isRTL()) {
    var jalali = Jalali.fromDateTime(date);
    return "${jalali.year} ${Texts.monthName[jalali.month - 1].translate} ${withDay ? jalali.day : ""}";
  } else {
    return "${Texts.monthName[date.month - 1].translate} ${withDay ? date.day : ""} ${date.year}";
  }
}

String fullTimeToText(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  if (isRTL()) {
    var jalali = Jalali.fromDateTime(date);
    return "${dayOfWeek(timestamp, fullText: true)} ${jalali.day} ${Texts.monthName[jalali.month - 1].translate}"
        " ${jalali.year}";
  } else {
    return "${dayOfWeek(timestamp, fullText: true)} ${date.day} ${Texts.monthName[date.month - 1].translate} ${date.year}";
  }
}

String dayOfWeek(int timestamp, {bool fullText = false}) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return fullText
      ? Texts.weekName[date.weekday - 1].translate
      : Texts.weekNameMini[date.weekday - 1].translate;
}

String dayOfMonth(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  if (isRTL()) {
    var jalali = Jalali.fromDateTime(date);
    return "${jalali.day}";
  } else {
    return "${date.day}";
  }
}
