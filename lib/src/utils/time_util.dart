import 'package:shamsi_date/shamsi_date.dart';

String timeToText(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var jalali = Jalali.fromDateTime(date);
  return "${jalali.day}/${jalali.month}/${jalali.year}";
}

String dayOfWeek(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  // var jalali = Jalali.fromDateTime(date);
  return "${date.weekday}";
}

String dayOfMonth(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var jalali = Jalali.fromDateTime(date);
  return "${jalali.day}";
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}
