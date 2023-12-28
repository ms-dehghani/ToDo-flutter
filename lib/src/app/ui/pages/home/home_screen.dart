import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/src/app/ui/pages/setting/setting_screen.dart';
import 'package:ToDo/src/app/ui/pages/task/list/task_list_page.dart';
import 'package:ToDo/src/app/ui/widgets/image/image_view.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/utils/navigator.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/navigation/bottom_navigation.dart';
import '../task/create/create_task_item_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  final pages = [
    TaskListPage(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark()
          ? getSelectedThemeColors().pageBackground
          : getSelectedThemeColors().onBackground,
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigation(
        key: const ValueKey("navigation"),
        pages: pages,
        backgroundColor: getSelectedThemeColors().onBackground,
        callback: (selectedPage) {
          setState(() {
            pageIndex = selectedPage;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToPage(
              context,
              CreateTaskItemPage(
                taskItem: TaskItem.empty(
                    timestamp: (pages[0] as TaskListPage).selectedDay.millisecondsSinceEpoch),
              )).then((value) {
            (pages[0] as TaskListPage).reload();
          });
        },
        backgroundColor: getSelectedThemeColors().primaryColor,
        child: ImageView(
          src: AppIcons.addFill,
          color: getSelectedThemeColors().textOnAccentColor,
          size: Insets.iconSize2XL,
        ),
      ),
    );
  }
}
