import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/theme/theme_color.dart';

class AnimatedContainerItem extends StatefulWidget {
  Widget child;

  BoxDecoration? firstDecoration;
  BoxDecoration? secondDecoration;

  EdgeInsetsGeometry? margin;

  Duration duration;

  Function()? onTap;

  AnimatedContainerItem({
    super.key,
    required this.child,
    this.firstDecoration,
    this.secondDecoration,
    this.margin,
    this.duration = const Duration(milliseconds: 300),
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimatedContainerItemState();
  }
}

class _AnimatedContainerItemState extends State<AnimatedContainerItem> {
  bool forwardAnimation = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          forwardAnimation = !forwardAnimation;
        });
        Timer(widget.duration, () => widget.onTap?.call());
      },
      child: AnimatedContainer(
        margin: widget.margin,
        duration: widget.duration,
        decoration: !forwardAnimation ? widget.firstDecoration : widget.secondDecoration,
        child: widget.child,
      ),
    );
  }
}
