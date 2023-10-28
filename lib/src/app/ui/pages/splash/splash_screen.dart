import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/src/app/ui/pages/task/list/task_list_page.dart';
import 'package:kardone/src/app/ui/widgets/image/image_view.dart';
import 'package:kardone/src/utils/device.dart';
import 'package:kardone/src/utils/theme_utils.dart';

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
            return TaskListPage();
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
