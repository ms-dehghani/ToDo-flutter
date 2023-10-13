import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/ui/widgets/check_box/check_box_item.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/utils/theme_utils.dart';
import 'package:kardone/src/utils/time_util.dart';

import '../../buttons/custom_flat_button.dart';
import '../../buttons/custom_raised_button.dart';
import '../../round_colored_container.dart';

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
