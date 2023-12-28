import 'dart:async';

import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/src/app/ui/pages/home/home_screen.dart';
import 'package:ToDo/src/app/ui/widgets/image/image_view.dart';
import 'package:ToDo/src/utils/device.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext context;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeScreen();
          },
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      color: getSelectedThemeColors().onBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: getWidth(context),
            height: getHeight(context) / 2,
            child: Center(
              child: ImageView(
                src: AppIcons.topSplash,
                size: 200,
              ),
            ),
          ),
          SvgPicture.asset(
            AppIcons.bottomSplash,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
