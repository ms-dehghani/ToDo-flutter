import 'package:flutter/material.dart';

class BottomNavigationItem {
  Widget page;
  Color pageBackgroundColor;
  String selectedIcon;
  String deselectedIcon;

  BottomNavigationItem(
      {required this.page,
      required this.pageBackgroundColor,
      required this.selectedIcon,
      required this.deselectedIcon});
}
