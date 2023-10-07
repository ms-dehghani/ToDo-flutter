import 'package:flutter/cupertino.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/utils/theme_utils.dart';
import 'package:kardone/src/utils/time_util.dart';

class CalenderRowItem extends StatefulWidget {
  int timestamp;
  bool isSelected;
  Function()? onSelect;

  AnimationController? textAnimationController;
  AnimationController? backgroundAnimationController;
  AnimationController? borderAnimationController;

  CalenderRowItem({
    super.key,
    required this.timestamp,
    this.isSelected = false,
    this.onSelect,
  });

  @override
  State<StatefulWidget> createState() {
    return _CalenderRowItemWidgetState();
  }

  void onDeselect() {
    textAnimationController?.reverse();
    backgroundAnimationController?.reverse();
    borderAnimationController?.reverse();
    isSelected = false;
  }
}

class _CalenderRowItemWidgetState extends State<CalenderRowItem> with TickerProviderStateMixin {
  Duration duration = const Duration(milliseconds: 300);

  Animation<Color?>? _animationText;
  Animation<Color?>? _borderContainer;
  Animation<Color?>? _animationBackground;

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    if (widget.textAnimationController != null) {
      return;
    }

    widget.textAnimationController = AnimationController(vsync: this, duration: duration);
    widget.backgroundAnimationController = AnimationController(vsync: this, duration: duration);
    widget.borderAnimationController = AnimationController(vsync: this, duration: duration);

    _animationText = ColorTween(
      begin: getSelectedThemeColors().primaryText,
      end: getSelectedThemeColors().textOnAccentColor,
    ).animate(widget.textAnimationController!);

    _borderContainer = ColorTween(
      begin: getSelectedThemeColors().borderColor,
      end: getSelectedThemeColors().accentColor,
    ).animate(widget.borderAnimationController!);

    _animationBackground = ColorTween(
      begin: getSelectedThemeColors().itemFillColor,
      end: getSelectedThemeColors().accentColor,
    ).animate(widget.backgroundAnimationController!);
  }

  @override
  void dispose() {
    widget.textAnimationController?.dispose();
    widget.backgroundAnimationController?.dispose();
    widget.borderAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.backgroundAnimationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (!widget.isSelected) {
              widget.textAnimationController?.forward();
              widget.backgroundAnimationController?.forward();
              widget.borderAnimationController?.forward();
            } else {
              widget.textAnimationController?.reverse();
              widget.backgroundAnimationController?.reverse();
              widget.borderAnimationController?.reverse();
            }
            widget.isSelected = !widget.isSelected;
            if (widget.isSelected) widget.onSelect?.call();
          },
          child: Container(
            width: Insets.calenderItemWidth,
            height: Insets.calenderItemHeight,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: Insets.sm),
            decoration: Drawable.calendarItemBorder(getSelectedThemeColors()).copyWith(
                color: _animationBackground?.value,
                border: Border.all(color: _borderContainer!.value!, width: Strokes.thin)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  dayOfMonth(widget.timestamp),
                  style: TextStyles.h1Bold.copyWith(color: _animationText!.value),
                ),
                Text(
                  dayOfWeek(widget.timestamp),
                  style: TextStyles.h3Bold.copyWith(color: _animationText!.value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
