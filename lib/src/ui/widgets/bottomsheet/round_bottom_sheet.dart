import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';

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
                        GestureDetector(
                          child: ImageView(src: AppIcons.closeOutline, size: Insets.iconSizeXL),
                          onTap: () {
                            Navigator.of(context).maybePop();
                          },
                        ),
                        ItemSplitter.thickSplitter,
                        Expanded(child: titleView ?? Container())
                      ],
                    )
                  : titleView ?? Container()),
            ),
            body,
          ],
        );
      });
}
