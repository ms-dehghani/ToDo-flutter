import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class CustomRoundNavigationBackground extends CustomPainter {
  Color backgroundColor;
  BuildContext context;

  CustomRoundNavigationBackground(this.context, this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.5839956);
    path_0.cubicTo(0, size.height * 0.4104515, size.width * 0.02082729, size.height * 0.2623382,
        size.width * 0.04901401, size.height * 0.2364794);
    path_0.cubicTo(size.width * 0.3934372, size.height * -0.07949706, size.width * 0.6065145,
        size.height * -0.07820441, size.width * 0.9509469, size.height * 0.2366294);
    path_0.cubicTo(size.width * 0.9791522, size.height * 0.2624088, size.width,
        size.height * 0.4105676, size.width, size.height * 0.5842029);
    path_0.lineTo(size.width, size.height * 0.5735294);
    path_0.lineTo(0, size.height * 0.5735294);
    path_0.lineTo(0, size.height * 0.5839956);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = backgroundColor;
    canvas.drawShadow(path_0, getSelectedThemeColors().secondaryText, 10.0, true);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
