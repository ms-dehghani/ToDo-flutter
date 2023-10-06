import 'package:flutter/cupertino.dart';
import 'package:kardone/res/dimens.dart';

class ApplicationAppBar extends StatelessWidget {
  Widget? leftWidget;
  Widget? rightWidget;
  Widget? centerWidget;

  ApplicationAppBar({super.key, this.centerWidget, this.leftWidget, this.rightWidget}) {
    centerWidget ??= SizedBox(width: Insets.buttonHeight,);
    leftWidget ??= Container();
    rightWidget ??= Container(width: Insets.buttonHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Insets.appBarHeight,
      padding: EdgeInsets.symmetric(horizontal: Insets.med),
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
