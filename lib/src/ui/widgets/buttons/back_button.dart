import 'package:flutter/cupertino.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/utils/direction_util.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class AppBarBackButton extends StatelessWidget{

  Function() onTap;

  AppBarBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Insets.backButtonHeight,
        height: Insets.backButtonHeight,
        padding: EdgeInsets.all(Insets.sm),
        decoration: Drawable.backButtonDecoration(getSelectedThemeColors()),
        child: RotatedBox(
          quarterTurns: isRTL()?0:-2,
          child: ImageView(
            src: AppIcons.back,
            size: Insets.iconSizeXL,
            color: getSelectedThemeColors().primaryText,
          ),
        ),
      ),
    );
  }


}