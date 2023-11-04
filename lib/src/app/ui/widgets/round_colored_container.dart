import 'package:flutter/cupertino.dart';
import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';

class RoundColoredContainer extends StatelessWidget {
  Widget child;
  Color color;
  EdgeInsetsGeometry? margin;

  double? width, height;

  RoundColoredContainer(
      {super.key, required this.child, required this.color, this.margin, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.symmetric(vertical: Insets.xs, horizontal: Insets.sm),
      decoration: Drawable.simpleRoundCorner(color),
      child: child,
    );
  }
}
