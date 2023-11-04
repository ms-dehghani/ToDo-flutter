extension DateOnlyCompare on DateTime {
  bool isSameDay({DateTime? date, int timestamp = 0}) {
    date ??= DateTime.fromMillisecondsSinceEpoch(timestamp);
    return year == date.year && month == date.month && day == date.day;
  }
}
