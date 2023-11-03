import 'dart:async';

import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/src/utils/device.dart';
import 'package:ToDo/src/utils/extentions/translates_string_extentions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:flutter/material.dart';
import 'package:ToDo/res/texts.dart';

import '../base/base_stateful_widget.dart';
import '../buttons/custom_flat_button.dart';
import '../buttons/custom_raised_button.dart';

class DatePicker extends StatefulWidget {
  String title = "";
  bool showOnlyYearMonth = false;
  int initialTime;
  bool showJalali = true;
  Function(int timestamp)? onDateSelected;

  DatePicker(
      {super.key, this.title = "",
      this.initialTime = 0,
      this.onDateSelected,
      this.showJalali = false,
      this.showOnlyYearMonth = false}) {
    if (title == "") title = Texts.chooseDatePicker;
    if (initialTime == 0) {
      initialTime = DateTime.now().millisecondsSinceEpoch;
    }
  }

  @override
  State<StatefulWidget> createState() => _DatePicker();
}

class _DatePicker extends BaseStatefulState<DatePicker> {
  int year = 0, month = 0, day = 0;
  double itemHeight = 0;

  late ListWheelScrollView yearList, monthList, dayList;

  var years = [0, 0, 0, 0, 0];

  @override
  void initState() {
    itemHeight = Insets.xl;

    _initYears();
    _setSelectedYear();
    _setSelectedMonth();
    _setSelectedDay();

    _goToDay();

    super.initState();
  }

  void _initYears() {
    int year = widget.showJalali
        ? Jalali.fromDateTime(DateTime.fromMillisecondsSinceEpoch(widget.initialTime)).year
        : DateTime.fromMillisecondsSinceEpoch(widget.initialTime).year;

    years[0] = year - 2;
    years[1] = years[0] + 1;
    years[2] = years[1] + 1;
    years[3] = years[2] + 1;
    years[4] = years[3] + 1;
  }

  void _setSelectedYear() {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.initialTime);

    int nowYear = widget.showJalali ? Jalali.fromDateTime(date).year : date.year;
    year = years.indexOf(nowYear);
  }

  void _setSelectedMonth() {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.initialTime);

    int nowMonth = widget.showJalali ? Jalali.fromDateTime(date).month : date.month;
    month = nowMonth - 1;
  }

  void _setSelectedDay() {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.initialTime);

    int nowDay = widget.showJalali ? Jalali.fromDateTime(date).day : date.day;
    day = nowDay - 1;
  }

  int _getMonthLength() {
    var date = DateTime.fromMillisecondsSinceEpoch(widget.initialTime);
    var result = widget.showJalali
        ? Jalali.fromDateTime(date).monthLength
        : DateTimeRange(start: date.copyWith(day: 1), end: DateTime(date.year, date.month + 1))
            .duration
            .inDays;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    const scrollPhysics = FixedExtentScrollPhysics();

    double listItemWidth = getWidth(context) * 0.8 / 3;

    yearList = ListWheelScrollView(
      itemExtent: Insets.xl,
      physics: scrollPhysics,
      overAndUnderCenterOpacity: 0.5,
      squeeze: 1.25,
      onSelectedItemChanged: (index) {
        setState(() {
          year = index;
        });
      },
      controller: FixedExtentScrollController(),
      children: List<Widget>.generate(
        years.length,
        (index) => Container(
          width: listItemWidth,
          alignment: Alignment.center,
          child: Text("${years[index]}",
              style: TextStyles.h3Bold.copyWith(
                  color: index == year
                      ? getSelectedThemeColors().primaryColor
                      : getSelectedThemeColors().primaryText,
                  fontSize: index == year ? FontSizes.s16 : FontSizes.s12)),
        ),
      ),
    );

    monthList = ListWheelScrollView(
      itemExtent: Insets.xl,
      physics: scrollPhysics,
      overAndUnderCenterOpacity: 0.5,
      squeeze: 1.25,
      onSelectedItemChanged: (index) {
        setState(() {
          month = index;
        });
      },
      controller: FixedExtentScrollController(),
      children: List<Widget>.generate(
        12,
        (index) => Container(
          width: listItemWidth,
          alignment: Alignment.center,
          child: Text(Texts.monthName[index].translate,
              style: TextStyles.h3Bold.copyWith(
                  color: index == month
                      ? getSelectedThemeColors().primaryColor
                      : getSelectedThemeColors().primaryText,
                  fontSize: index == month ? FontSizes.s16 : FontSizes.s12)),
        ),
      ),
    );

    dayList = ListWheelScrollView(
      itemExtent: Insets.xl,
      physics: scrollPhysics,
      overAndUnderCenterOpacity: 0.5,
      squeeze: 1.25,
      onSelectedItemChanged: (index) {
        setState(() {
          day = index;
        });
      },
      controller: FixedExtentScrollController(),
      children: List<Widget>.generate(
        _getMonthLength(),
        (index) => Container(
          width: listItemWidth,
          alignment: Alignment.center,
          child: Text(index < 9 ? "0${index + 1}" : "${index + 1}",
              style: TextStyles.h3Bold.copyWith(
                  color: index == day
                      ? getSelectedThemeColors().primaryColor
                      : getSelectedThemeColors().primaryText,
                  fontSize: index == day ? FontSizes.s16 : FontSizes.s12)),
        ),
      ),
    );

    return Container(
      height: Insets.scale * 280,
      color: getSelectedThemeColors().pageBackground,
      child: Column(
        children: [
          Container(
            height: Insets.buttonHeight,
            alignment: Alignment.centerRight,
            padding:
                EdgeInsets.only(left: getWidth(context) * 0.05, right: getWidth(context) * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${!widget.showOnlyYearMonth ? "${day + 1} " : ""}${Texts.monthName[month].translate} ${years[year]}",
                  style: TextStyles.h3Bold.copyWith(color: getSelectedThemeColors().primaryColor),
                ),
                CustomFlatButton(
                  elevation: 0,
                  onTap: () {
                    widget.initialTime = DateTime.now().millisecondsSinceEpoch;
                    _setSelectedYear();
                    _setSelectedMonth();
                    _setSelectedDay();
                    _goToDay();
                  },
                  fillColor: getSelectedThemeColors().itemFillColor,
                  rippleColor: getSelectedThemeColors().primaryColor,
                  child: Text(
                    Texts.today.translate,
                    style: TextStyles.h3.copyWith(color: getSelectedThemeColors().primaryColor),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: Insets.scale * 160,
            width: getWidth(context) * 0.9,
            decoration: BoxDecoration(
              color: getSelectedThemeColors().pageBackground,
              borderRadius: Corners.hgBorder,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (widget.showOnlyYearMonth
                    ? const SizedBox(width: 0)
                    : Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: Drawable.timeAndDatePickerBackItemDecoration(
                                  getSelectedThemeColors()),
                              width: listItemWidth,
                              height: Insets.backButtonHeight,
                            ),
                          ),
                          SizedBox(
                            width: listItemWidth,
                            height: Insets.scale * 170,
                            child: dayList,
                          ),
                        ],
                      )),
                ItemSplitter.thickSplitter,
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration:
                            Drawable.timeAndDatePickerBackItemDecoration(getSelectedThemeColors()),
                        width: listItemWidth,
                        height: Insets.backButtonHeight,
                      ),
                    ),
                    SizedBox(
                      width: listItemWidth,
                      height: Insets.scale * 170,
                      child: monthList,
                    ),
                  ],
                ),
                ItemSplitter.thickSplitter,
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration:
                            Drawable.timeAndDatePickerBackItemDecoration(getSelectedThemeColors()),
                        width: listItemWidth,
                        height: Insets.backButtonHeight,
                      ),
                    ),
                    SizedBox(
                      width: listItemWidth,
                      height: Insets.scale * 170,
                      child: yearList,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ItemSplitter.thickSplitter,
          CustomRaisedButton(
            size: Size(getWidth(context) * 0.9, Insets.backButtonHeight),
            fillColor: getSelectedThemeColors().primaryColor,
            child: Text(
              Texts.ok.translate,
              style: TextStyles.h3Bold.copyWith(color: getSelectedThemeColors().textOnAccentColor),
            ),
            onTap: () {
              if (widget.onDateSelected != null) {
                var date = widget.showJalali
                    ? Jalali(years[year], month + 1, day + 1).toDateTime()
                    : DateTime(years[year], month + 1, day + 1);
                date =
                    date.add(Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute));
                widget.onDateSelected!.call(date.millisecondsSinceEpoch);
              }
              Navigator.of(context).maybePop();
            },
          ),
          ItemSplitter.medSplitter,
        ],
      ),
    );
  }

  void _goToDay() {
    Timer(const Duration(milliseconds: 200), () {
      yearList.controller!.animateTo(itemHeight * (year),
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

      monthList.controller!.animateTo(itemHeight * month,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

      dayList.controller!.animateTo(itemHeight * day,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

}

// class SnappingListScrollPhysics extends ScrollPhysics {
//   final double mainAxisStartPadding;
//   final double itemExtent;
//
//   const SnappingListScrollPhysics(
//       {ScrollPhysics? parent, this.mainAxisStartPadding = 0.0, required this.itemExtent})
//       : super(parent: parent);
//
//   @override
//   SnappingListScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return SnappingListScrollPhysics(
//         parent: buildParent(ancestor)!,
//         mainAxisStartPadding: mainAxisStartPadding,
//         itemExtent: itemExtent);
//   }
//
//   double _getItem(ScrollPosition position) {
//     return (position.pixels - mainAxisStartPadding) / itemExtent;
//   }
//
//   double _getPixels(ScrollPosition position, double item) {
//     return min(item * itemExtent, position.maxScrollExtent);
//   }
//
//   double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
//     double item = _getItem(position);
//     if (velocity < -tolerance.velocity) {
//       item -= 0.5;
//     } else if (velocity > tolerance.velocity) item += 0.5;
//     return _getPixels(position, item.roundToDouble());
//   }
//
//   @override
//   Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
//     // If we're out of range and not headed back in range, defer to the parent
//     // ballistics, which should put us back in range at a page boundary.
//     if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//         (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
//       return super.createBallisticSimulation(position, velocity);
//     }
//     final Tolerance tolerance = this.tolerance;
//     final double target = _getTargetPixels(position as ScrollPosition, tolerance, velocity);
//     if (target != position.pixels) {
//       return ScrollSpringSimulation(spring, position.pixels, target, velocity,
//           tolerance: tolerance);
//     }
//     return null;
//   }
//
//   @override
//   bool get allowImplicitScrolling => false;
// }
