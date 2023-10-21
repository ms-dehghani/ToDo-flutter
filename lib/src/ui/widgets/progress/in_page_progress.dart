import 'package:flutter/cupertino.dart';
import 'package:kardone/res/dimens.dart';
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
