import 'package:ToDo/res/dimens/insets.dart';
import 'package:ToDo/res/dimens/strokes.dart';
import 'package:ToDo/res/drawable/drawable.dart';
import 'package:ToDo/res/styles/text_style.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

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

class _PriorityButtonWidgetState extends State<PriorityButtonWidget>
    with TickerProviderStateMixin {
  Duration duration = const Duration(milliseconds: 300);

  late Animation<Color?> _animationText;
  late Animation<Color?> _animationBackground;

  @override
  void initState() {
    super.initState();
    widget.textAnimationController =
        AnimationController(vsync: this, duration: duration);
    widget.backgroundAnimationController =
        AnimationController(vsync: this, duration: duration);

    _animationText = ColorTween(
      begin: widget.priorityItem.color,
      end: Colors.white,
    ).animate(widget.textAnimationController);

    _animationBackground = ColorTween(
      begin: getSelectedThemeColors().itemFillColor,
      end: widget.priorityItem.color,
    ).animate(widget.backgroundAnimationController);

    if (widget.isSelected) {
      _doAnimate(widget.isSelected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.backgroundAnimationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            _doAnimate(!widget.isSelected);
            widget.isSelected = !widget.isSelected;
            if (widget.isSelected) widget.onSelect?.call();
          },
          child: Container(
            width: 64,
            height: 48,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: Insets.sm),
            decoration: Drawable.simpleBorder(getSelectedThemeColors())
                .copyWith(
                    color: _animationBackground.value,
                    border: Border.all(
                        color: widget.priorityItem.color, width: Strokes.thin)),
            child: Text(
              widget.priorityItem.title.translate,
              style: TextStyles.h3.copyWith(color: _animationText.value),
            ),
          ),
        );
      },
    );
  }

  void _doAnimate(bool forward) {
    if (forward) {
      widget.textAnimationController.forward();
      widget.backgroundAnimationController.forward();
    } else {
      widget.textAnimationController.reverse();
      widget.backgroundAnimationController.reverse();
    }
  }
}
