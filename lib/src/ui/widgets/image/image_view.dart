import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageView extends StatelessWidget {
  String src;
  double size;
  Color? color;

  bool local;

  ImageView({required this.src, required this.size, this.color, this.local = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: _localIcon(),
    );
  }

  Widget _localIcon() {
    return SvgPicture.asset(
      src,
      colorFilter: ColorFilter.mode(color ?? Colors.black45, BlendMode.srcIn),
    );
  }
}
