import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/src/utils/extentions/date_extentions.dart';

import 'calender_row_item.dart';

class CalenderView extends StatefulWidget {
  DateTime start, end;

  Function(DateTime)? onSelect;

  CalenderView({
    super.key,
    required this.start,
    required this.end,
    this.onSelect,
  });

  @override
  State<StatefulWidget> createState() {
    return _CalenderViewState();
  }
}

class _CalenderViewState extends State<CalenderView> with TickerProviderStateMixin {
  List<CalenderRowItem> items = [];
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    DateTime time = widget.start;
    while (time.isBefore(widget.end)) {
      items.add(CalenderRowItem(
        key: ObjectKey(time.millisecondsSinceEpoch),
        timestamp: time.millisecondsSinceEpoch,
        isSelected: time.isSameDate(selectedDay),
        onSelect: (dTime) {
          items
              .firstWhere((element) => element.timestamp == selectedDay.millisecondsSinceEpoch)
              .onDeselect();
          selectedDay = dTime;
          widget.onSelect?.call(selectedDay);
        },
      ));
      if (time.isSameDate(selectedDay)) selectedDay = time;
      time = time.add(const Duration(days: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Insets.calenderListInTaskHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding:
            EdgeInsets.only(top: (Insets.calenderListInTaskHeight - Insets.calenderItemHeight) / 2),
        shrinkWrap: true,
        children: items,
      ),
    );
  }

  Widget _buildItem(int i) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 80,
          padding: const EdgeInsets.all(20),
          color: Colors.blue[100 * ((i % 8) + 1)],
          child: Center(
            child: Text(
              i.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
