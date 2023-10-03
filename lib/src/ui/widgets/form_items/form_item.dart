import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class FormItem extends StatelessWidget {
  String title;
  Widget child;

  FormItem({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.h2.copyWith(color: getSelectedThemeColors().primaryText),
        ),
        ItemSplitter.thinSplitter,
        child
      ],
    );
  }
}
