import 'package:flutter/material.dart';

class SwitchView extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double radius;
  final double padding;
  final Duration animationDuration;
  final Color uncheckColor;
  final Color checkColor;

  const SwitchView(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.radius = 24.0,
      this.padding = 4.0,
      this.uncheckColor = Colors.grey,
      this.checkColor = Colors.blue,
      this.animationDuration = const Duration(milliseconds: 150)})
      : super(key: key);

  @override
  _SwitchViewState createState() => _SwitchViewState();
}

class _SwitchViewState extends State<SwitchView> with SingleTickerProviderStateMixin {
  late Animation<Color?> _colorAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.animationDuration);
    _colorAnimation = ColorTween(begin: widget.uncheckColor, end: widget.checkColor)
        .animate(_animationController);
    if (widget.value) _animationController.value = 1.0;
  }

  double containerWidth = 44.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse().whenComplete(() {
                widget.onChanged(false);
              });
            } else {
              _animationController.forward().whenComplete(() => widget.onChanged(true));
            }
          },
          child: Container(
            width: containerWidth,
            height: 28.0,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: _colorAnimation.value,
            ),
            child: Transform.translate(
              offset: Offset(
                  widget.padding +
                      _animationController.value * ((containerWidth - (3 * widget.padding)) / 2),
                  0),
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.radius - widget.padding),
                    color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
