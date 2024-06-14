import 'package:ToDo/res/dimens/insets.dart';
import 'package:ToDo/res/drawable/item_splitter.dart';
import 'package:ToDo/res/styles/text_style.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {
  String title;
  Widget child;

  FormItem({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.sm),
          child: Text(
            title,
            style: TextStyles.h2
                .copyWith(color: getSelectedThemeColors().primaryText),
          ),
        ),
        ItemSplitter.ultraThinSplitter,
        child
      ],
    );
  }
}
