import 'package:flutter/cupertino.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class TaskActionButton extends StatelessWidget {
  String icon;
  String title;
  Color color;
  Color? rippleColor;

  Function()? onTap;

  TaskActionButton(
      {required this.icon, required this.title, required this.color, this.rippleColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageView(
            src: icon,
            size: Insets.iconSizeXL,
            color: color,
          ),
          Text(
            title,
            style: TextStyles.h3.copyWith(color: color),
          )
        ],
      ),
    );
  }
}
