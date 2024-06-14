import 'package:ToDo/res/dimens/insets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InPageProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Insets.buttonHeight,
      height: Insets.buttonHeight,
      child: Lottie.asset('assets/lottie/loading.json'),
    );
  }
}
