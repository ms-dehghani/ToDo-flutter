import 'dart:ui';

import 'package:ToDo/res/color.dart';
import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/res/texts.dart';
import 'package:ToDo/src/utils/device.dart';
import 'package:ToDo/src/utils/direction_util.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

import '../buttons/custom_flat_button.dart';
import '../buttons/flat_border_button.dart';
import '../image/image_view.dart';
import '../picker/date_picker.dart';
import 'bottomsheet_title_item.dart';

Future<dynamic> showRoundBottomSheet(BuildContext context, Widget body,
    {bool showClose = true, Widget? titleView, Color? color}) {
  color ??= getSelectedThemeColors().onBackground;
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: Corners.bottomSheetTopBorder),
      backgroundColor: Colors.transparent,
      barrierColor: UiColors.bottomSheetBackDropBackground,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: Drawable.bottomSheetDecoration(color!),
                  padding: EdgeInsets.all(Insets.pagePadding),
                  child: (showClose
                      ? Row(
                          children: [
                            Expanded(child: titleView ?? Container()),
                            ItemSplitter.thickSplitter,
                            GestureDetector(
                              child: ImageView(
                                  src: AppIcons.closeOutline,
                                  size: Insets.iconSizeXL,
                                  color: getSelectedThemeColors().secondaryText),
                              onTap: () {
                                Navigator.of(context).maybePop();
                              },
                            ),
                          ],
                        )
                      : titleView ?? Container()),
                ),
                body,
              ],
            ),
          ),
        );
      });
}

Future<dynamic> showDatePickerDialog(BuildContext context,
    {String title = "",
    int initialTime = 0,
    bool showOnlyYearMonth = false,
    Function(int timestamp)? onDateSelected}) {
  return showRoundBottomSheet(
      context,
      titleView: BottomSheetTitleItem(
          color: getSelectedThemeColors().iconGreen,
          title: Texts.selectDateTitle.translate,
          iconSrc: AppIcons.calendar),
      SizedBox(
        width: getWidth(context),
        height: 285,
        child: DatePicker(
          title: title,
          initialTime: initialTime,
          showOnlyYearMonth: showOnlyYearMonth,
          showJalali: isRTL(),
          onDateSelected: (timestamp) {
            onDateSelected?.call(timestamp);
          },
        ),
      ));
}

Future<dynamic> showAskQuestionDialog(BuildContext context,
    {String text = "",
    Color titleBarColor = UiColors.iconRed,
    String titleBarIcon = AppIcons.danger,
    String leftButtonText = "",
    String rightButtonText = "",
    Color leftButtonColor = UiColors.green,
    Color rightButtonColor = UiColors.secondaryText,
    Function()? leftButtonOnClick,
    Function()? rightButtonOnClick}) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: Corners.bottomSheetTopBorder),
      backgroundColor: Colors.transparent,
      barrierColor: UiColors.bottomSheetBackDropBackground,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: Drawable.bottomSheetDecoration(titleBarColor),
                height: Insets.buttonHeight,
                child: Center(
                  child: ImageView(
                    size: Insets.iconSizeL,
                    src: titleBarIcon,
                    color: getSelectedThemeColors().itemFillColor,
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: Insets.buttonHeight,
                    color: titleBarColor,
                  ),
                  Container(
                    height: Insets.buttonHeight * 3,
                    padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
                    decoration:
                        Drawable.bottomSheetDecoration(getSelectedThemeColors().itemFillColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ItemSplitter.thickSplitter,
                        Text(
                          text,
                          style:
                              TextStyles.h2.copyWith(color: getSelectedThemeColors().primaryText),
                        ),
                        ItemSplitter.thickSplitter,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomFlatButton(
                              elevation: 0,
                              size: Size(getWidth(context) / 2 - Insets.d24, Insets.buttonHeight),
                              fillColor: leftButtonColor,
                              child: Text(
                                leftButtonText,
                                style: TextStyles.h2Bold
                                    .copyWith(color: getSelectedThemeColors().textOnAccentColor),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .maybePop()
                                    .then((value) => leftButtonOnClick?.call());
                              },
                            ),
                            FlatBorderButton(
                              size: Size(getWidth(context) / 2 - Insets.d24, Insets.buttonHeight),
                              borderColor: rightButtonColor,
                              backColor: getSelectedThemeColors().itemFillColor,
                              rippleColor: rightButtonColor,
                              onTap: () {
                                Navigator.of(context)
                                    .maybePop()
                                    .then((value) => rightButtonOnClick?.call());
                              },
                              child: Text(
                                rightButtonText,
                                style: TextStyles.h2Bold
                                    .copyWith(color: getSelectedThemeColors().secondaryText),
                              ),
                            )
                          ],
                        ),
                        ItemSplitter.thickSplitter,
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}

Future<dynamic> showDeleteDialog(BuildContext context, {String text = "", Function()? onDeleted}) {
  return showAskQuestionDialog(context,
      titleBarColor: UiColors.iconRed,
      titleBarIcon: AppIcons.danger,
      text: Texts.deleteQuestion.translate,
      leftButtonColor: UiColors.iconRed,
      leftButtonText: Texts.deleteLeftButton.translate,
      rightButtonText: Texts.deleteRightButton.translate,
      leftButtonOnClick: onDeleted);
}

Future<dynamic> showDoneTaskDialog(BuildContext context, {required Function()? onDone}) {
  return showAskQuestionDialog(context,
      titleBarColor: UiColors.iconGreen,
      titleBarIcon: AppIcons.doneTitle,
      text: Texts.doneQuestion.translate,
      leftButtonText: Texts.doneLeftButton.translate,
      rightButtonText: Texts.doneRightButton.translate,
      leftButtonOnClick: onDone);
}
