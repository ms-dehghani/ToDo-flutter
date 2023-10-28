import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/src/utils/direction_util.dart';
import 'package:kardone/src/utils/theme_utils.dart';

import '../image/image_view.dart';

class AppBarBackButton extends StatelessWidget {
  Function() onTap;

  AppBarBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: Insets.backButtonHeight,
        height: Insets.backButtonHeight,
        child: InkWell(
          borderRadius: Corners.hgBorder,
          splashColor: getSelectedThemeColors().primaryColor.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () {
            onTap.call();
          },
          child: Ink(
            decoration: Drawable.backButtonDecoration(getSelectedThemeColors()),
            child: Container(
              width: Insets.backButtonHeight,
              height: Insets.backButtonHeight,
              padding: EdgeInsets.all(Insets.sm),
              child: RotatedBox(
                quarterTurns: isRTL() ? 0 : -2,
                child: ImageView(
                  src: AppIcons.back,
                  size: Insets.iconSizeXL,
                  color: getSelectedThemeColors().primaryText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
