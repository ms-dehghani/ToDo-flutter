import 'package:flutter/cupertino.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class AppBarBackButton extends StatelessWidget{

  Function() onTap;

  AppBarBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Insets.buttonHeight,
        height: Insets.buttonHeight,
        decoration: Drawable.backButtonDecoration(getSelectedThemeColors()),
      ),
    );
  }


}