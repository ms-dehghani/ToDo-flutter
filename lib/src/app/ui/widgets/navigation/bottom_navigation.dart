import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/src/app/ui/widgets/navigation/bottom_navigation_item.dart';
import 'package:ToDo/src/utils/device.dart';
import 'package:flutter/material.dart';

import '../image/image_view.dart';
import '../round_rect/custom_round_navigation_background.dart';

class BottomNavigation extends StatefulWidget {
  final List<BottomNavigationItem> pages;
  final Color backgroundColor;
  final Function(int selectedPage) callback;

  BottomNavigation(
      {required this.pages, required this.backgroundColor, required this.callback, super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int pageIndex = 0;

  final animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        CustomPaint(
          size: Size(getWidth(context), Insets.buttonHeight * 1.5),
          painter: CustomRoundNavigationBackground(context, widget.backgroundColor),
        ),
        Padding(
          padding: EdgeInsets.only(top: Insets.xl),
          child: Container(
            width: getWidth(context),
            height: Insets.backButtonHeight,
            padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
            color: widget.backgroundColor,
          ),
        ),
        BottomAppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          height: Insets.buttonHeight * 1.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.pages
                .asMap()
                .keys
                .toList()
                .map((index) => _navigationBottomItem(
                    index, widget.pages[index].selectedIcon, widget.pages[index].deselectedIcon))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _navigationBottomItem(int index, String selectedIcon, String deselectedIcon) {
    return AnimatedSwitcher(
      duration: animationDuration,
      child: IconButton(
        key: ValueKey<int>(pageIndex),
        enableFeedback: false,
        onPressed: () {
          setState(() {
            pageIndex = index;
            widget.callback.call(pageIndex);
          });
        },
        icon: ImageView(
          size: Insets.d24,
          src: pageIndex == index ? selectedIcon : deselectedIcon,
        ),
      ),
    );
  }
}
