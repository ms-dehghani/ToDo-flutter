import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/res/theme/theme_color.dart';
import 'package:kardone/src/model/items/tasks/priority/pojo/priority_item.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class PriorityButtonWidget extends StatefulWidget {
  PriorityItem priorityItem;
  bool isSelected = false;
  Function()? onSelect;

  late AnimationController textAnimationController;
  late AnimationController backgroundAnimationController;

  PriorityButtonWidget({
    super.key,
    required this.priorityItem,
    this.isSelected = false,
    this.onSelect,
  });

  @override
  State<StatefulWidget> createState() {
    return _PriorityButtonWidgetState();
  }

  void onDeselect() {
    textAnimationController.reverse();
    backgroundAnimationController.reverse();
    isSelected = false;
  }
}

class _PriorityButtonWidgetState extends State<PriorityButtonWidget> with TickerProviderStateMixin {
  Duration duration = const Duration(milliseconds: 300);

  late Animation<Color?> _animationText;
  late Animation<Color?> _animationBackground;

  @override
  void initState() {
    super.initState();
    widget.textAnimationController = AnimationController(vsync: this, duration: duration);
    widget.backgroundAnimationController = AnimationController(vsync: this, duration: duration);

    _animationText = ColorTween(
      begin: widget.priorityItem.color,
      end: Colors.white,
    ).animate(widget.textAnimationController);

    _animationBackground = ColorTween(
      begin: getSelectedThemeColors().itemFillColor,
      end: widget.priorityItem.color,
    ).animate(widget.backgroundAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.backgroundAnimationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (!widget.isSelected) {
              widget.textAnimationController.forward();
              widget.backgroundAnimationController.forward();
            } else {
              widget.textAnimationController.reverse();
              widget.backgroundAnimationController.reverse();
            }
            widget.isSelected = !widget.isSelected;
            if (widget.isSelected) widget.onSelect?.call();
          },
          child: Container(
            width: 60,
            height: 34,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: Insets.sm),
            decoration: Drawable.simpleBorder(getSelectedThemeColors()).copyWith(
                color: _animationBackground.value,
                border: Border.all(color: widget.priorityItem.color, width: Strokes.thin)),
            child: Text(
              widget.priorityItem.title,
              style: TextStyles.h3.copyWith(color: _animationText.value),
            ),
          ),
        );
      },
    );
  }
}
