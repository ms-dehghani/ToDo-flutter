import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';

class ApplicationAppBar extends StatelessWidget {
  Widget? leftWidget;
  Widget? rightWidget;
  Widget? centerWidget;
  Color? color;

  ApplicationAppBar({super.key, this.centerWidget, this.leftWidget, this.rightWidget , this.color}) {
    centerWidget ??= SizedBox(width: Insets.buttonHeight,);
    leftWidget ??= Container();
    rightWidget ??= Container(width: Insets.buttonHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Insets.appBarHeight,
      color: color ?? Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
      alignment: Alignment.center,
      child: Row(
        children: [
          leftWidget!,
          Expanded(
            child: Center(child: centerWidget!),
          ),
          rightWidget!,
        ],
      ),
    );
  }
}
