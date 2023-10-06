import 'package:flutter/cupertino.dart';

class ImageView extends StatelessWidget {
  String src;
  double size;
  Color? color;

  ImageView({required this.src, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
    );
  }
}
