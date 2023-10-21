import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/texts.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/utils/device.dart';
import 'package:kardone/src/utils/extentions/translates_string_extentions.dart';
import 'package:kardone/src/utils/theme_utils.dart';

import '../picker/date_picker.dart';
import 'bottomsheet_title_item.dart';

Future<dynamic> showRoundBottomSheet(BuildContext context, Widget body,
    {bool showClose = true, Widget? titleView, Color? color = Colors.white}) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: Corners.hgTopBorder),
      backgroundColor: color,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: color,
              height: Insets.buttonHeight,
              padding: EdgeInsets.all(Insets.med),
              child: (showClose
                  ? Row(
                      children: [
                        Expanded(child: titleView ?? Container()),
                        ItemSplitter.thickSplitter,
                        GestureDetector(
                          child: ImageView(src: AppIcons.closeOutline, size: Insets.iconSizeXL),
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
          onDateSelected: (timestamp) {
            onDateSelected?.call(timestamp);
          },
        ),
      ));
}
