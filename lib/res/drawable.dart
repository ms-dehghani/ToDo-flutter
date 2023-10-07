import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/color.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/theme/theme_color.dart';

class Drawable {
  static BoxDecoration simpleRoundCorner(Color color) => BoxDecoration(
        color: color,
        borderRadius: Corners.lgBorder,
      );

  static BoxDecoration simpleBorder(ThemeColor color) => BoxDecoration(
      color: color.itemFillColor,
      borderRadius: Corners.medBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration calendarItemBorder(ThemeColor color) => BoxDecoration(
      color: color.itemFillColor,
      borderRadius: Corners.xxlBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration taskActionsDecoration(ThemeColor color) => BoxDecoration(
      color: UiColors.liteBackground,
      borderRadius: Corners.xxxlBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));

  static BoxDecoration backButtonDecoration(ThemeColor color) => BoxDecoration(
      color: UiColors.liteBackground,
      borderRadius: Corners.hgBorder,
      border: Border.all(color: color.borderColor, width: Strokes.thin));


  static BoxDecoration dotedBorderDecoration(ThemeColor color) => BoxDecoration(
      color: UiColors.iconGreen.withOpacity(0.2),
      borderRadius: Corners.hgBorder,);

  static BoxDecoration itemDetailDecoration(ThemeColor color) =>
      BoxDecoration(color: color.itemFillColor, boxShadow: Shadows.small);
}

class AppIcons{

  static const  String addFill = "assets/images/ic_add_fill.svg";
  static const  String back = "assets/images/ic_back.svg";
  static const  String calendar = "assets/images/ic_calendar.svg";
  static const  String calendarFill = "assets/images/ic_calendar_fill.svg";
  static const  String category = "assets/images/ic_category.svg";
  static const  String categoryOutline = "assets/images/ic_category_outline.svg";
  static const  String changeDate = "assets/images/ic_change_date.svg";
  static const  String clock = "assets/images/ic_clock.svg";
  static const  String closeOutline = "assets/images/ic_close_outline.svg";
  static const  String delete = "assets/images/ic_delete.svg";
  static const  String descriptionFill = "assets/images/ic_description_fill.svg";
  static const  String descriptionOutline = "assets/images/ic_description_outline.svg";
  static const  String done = "assets/images/ic_done.svg";
  static const  String doneChecked = "assets/images/ic_done_checked.svg";
  static const  String dotsHorizontal = "assets/images/ic_dots_horizontal.svg";
  static const  String edit = "assets/images/ic_edit.svg";
  static const  String priorityFill = "assets/images/ic_priority.svg";
  static const  String priorityOutline = "assets/images/ic_priority_outline.svg";

}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(color: const Color(0xff333333).withOpacity(.15), spreadRadius: 0, blurRadius: 10),
      ];

  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];
}
