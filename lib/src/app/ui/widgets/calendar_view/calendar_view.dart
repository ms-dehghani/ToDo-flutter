import 'dart:async';

import 'package:ToDo/res/dimens/insets.dart';
import 'package:ToDo/res/string/texts.dart';
import 'package:ToDo/res/styles/text_style.dart';
import 'package:ToDo/src/utils/direction_util.dart';
import 'package:ToDo/src/utils/extensions/date_extensions.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:ToDo/src/utils/time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class _CalenderViewState extends State<CalenderView>
    with TickerProviderStateMixin {
  List<CalenderRowItem> items = [];
  DateTime selectedDay = DateTime.now();

  var controller = FixedExtentScrollController();
  int _selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();
    setData();
    animateToItem(((items.length - 1) ~/ 2));
  }

  void animateToItem(int index,
      {Duration duration = const Duration(milliseconds: 100)}) {
    Timer(duration, () {
      controller.animateToItem(index,
          duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    });
  }

  void setData() {
    DateTime time = widget.start;
    while (time.isBefore(widget.end)) {
      items.add(CalenderRowItem(
        key: ObjectKey(time.millisecondsSinceEpoch),
        timestamp: time.millisecondsSinceEpoch,
        isSelected: time.isSameDay(date: selectedDay),
        onSelect: (dTime) {
          _setItemClicked(dTime);
        },
      ));
      if (time.isSameDay(date: selectedDay)) selectedDay = time;
      time = time.add(const Duration(days: 1));
    }
  }

  void _setItemClicked(DateTime dTime) {
    items
        .firstWhere(
            (element) => selectedDay.isSameDay(timestamp: element.timestamp))
        .deselect();
    items
        .firstWhere((element) => dTime.isSameDay(timestamp: element.timestamp))
        .select();
    selectedDay = dTime;
    widget.onSelect?.call(selectedDay);
    animateToItem(_findItem(selectedDay));
    setState(() {
      selectedDay = dTime;
    });
  }

  int _findItem(DateTime item) {
    for (int i = 0; i < items.length; i++) {
      if (item.isSameDay(timestamp: items[i].timestamp)) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Insets.calenderListInTaskHeight,
      child: Column(
        children: [
          calenderTitle(),
          Expanded(
            child: RotatedBox(
              quarterTurns: isRTL() ? -3 : -1,
              child: ListWheelScrollView(
                diameterRatio: 3,
                offAxisFraction: isRTL() ? -1.25 : 1.25,
                itemExtent: Insets.calenderItemWidth + Insets.med,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    _selectedItemIndex = value;
                  });
                },
                controller: controller,
                children: items
                    .map((e) => RotatedBox(
                          quarterTurns: isRTL() ? 3 : 1,
                          child: e,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget calenderTitle() {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.d24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_calenderMonth(), _calenderGoToToday()],
      ),
    );
  }

  Widget _calenderMonth() {
    return Row(
      children: [
        Text(
          timeToText(items[_selectedItemIndex].timestamp, withDay: false),
          style: TextStyles.h2Bold
              .copyWith(color: getSelectedThemeColors().primaryText),
        )
      ],
    );
  }

  Widget _calenderGoToToday() {
    return GestureDetector(
        onTap: () {
          if (!selectedDay.isSameDay(date: DateTime.now())) {
            _setItemClicked(DateTime.now());
          } else {
            animateToItem(_findItem(selectedDay));
          }
        },
        child: Text(
          Texts.goToday.translate,
          style: TextStyles.h3Bold
              .copyWith(color: getSelectedThemeColors().accentColor),
        ));
  }
}
