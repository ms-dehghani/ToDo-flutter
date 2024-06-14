import 'package:ToDo/res/dimens/insets.dart';
import 'package:ToDo/res/drawable/item_splitter.dart';
import 'package:ToDo/res/styles/text_style.dart';
import 'package:flutter/material.dart';

import '../image/image_view.dart';

class BottomSheetTitleItem extends StatelessWidget {
  String title;
  String iconSrc;
  Color color;

  BottomSheetTitleItem({
    super.key,
    required this.title,
    required this.iconSrc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageView(
          src: iconSrc,
          size: Insets.iconSizeXL,
          color: color,
        ),
        ItemSplitter.thinSplitter,
        Expanded(
            child: Text(
          title,
          style: TextStyles.h2Bold.copyWith(color: color),
        ))
      ],
    );
  }
}
