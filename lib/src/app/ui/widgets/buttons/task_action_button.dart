import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/text_style.dart';

import '../image/image_view.dart';

class TaskActionButton extends StatelessWidget {
  String icon;
  String title;
  Color color;
  Color? rippleColor;

  Function()? onTap;

  TaskActionButton(
      {super.key, required this.icon, required this.title, required this.color, this.rippleColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Insets.buttonHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: Corners.hgBorder,
          splashColor: rippleColor ?? color.withOpacity(0.2),
          highlightColor: Colors.transparent,
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
        ),
      ),
    );
  }
}
