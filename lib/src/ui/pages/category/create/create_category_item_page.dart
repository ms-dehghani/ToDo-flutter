import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/di/di.dart';
import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/category/create_update/bloc/category_create_update_bloc.dart';
import 'package:kardone/src/logic/category/create_update/bloc/category_create_update_event.dart';
import 'package:kardone/src/logic/category/create_update/bloc/category_create_update_page_data.dart';
import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';
import 'package:kardone/src/ui/widgets/base/widget_view_template.dart';
import 'package:kardone/src/ui/widgets/buttons/custom_raised_button.dart';
import 'package:kardone/src/ui/widgets/items/form/form_item.dart';
import 'package:kardone/src/ui/widgets/items/form/text_filed_item.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class CreateCategoryItemPage extends StatelessWidget with WidgetViewTemplate {
  late CategoryCreateOrUpdateBloc bloc;

  CategoryItem categoryItem;

  CreateCategoryItemPage({required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryCreateOrUpdateBloc>(
          create: (BuildContext context) => bloc = CategoryCreateOrUpdateBloc(
              categoryRepository: DI.instance().getCategoryRepository(),
              categoryItem: categoryItem),
        ),
      ],
      child: Material(
        color: getSelectedThemeColors().onBackground,
        child: SafeArea(child: showPage(context)),
      ),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Insets.med, right: Insets.med, bottom: Insets.med),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ItemSplitter.thinSplitter,
          _titleWidget(),
          ItemSplitter.thinSplitter,
          _createButton()
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return FormItem(
        title: "title",
        child: TextFiledItem(
          hint: 'text',
          text: categoryItem.title,
          onValueChange: (title) {
            categoryItem.title = title;
            bloc.add(UpdateUI());
          },
        ));
  }

  Widget _createButton() {
    return BlocConsumer<CategoryCreateOrUpdateBloc, CategoryCreateUpdateBlocPageData>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: CustomRaisedButton(
            elevation: 0,
            size: Size(double.infinity, Insets.buttonHeight),
            fillColor: state.item!.title.isEmpty
                ? getSelectedThemeColors().accentLiteColor
                : getSelectedThemeColors().accentColor,
            rippleColor: getSelectedThemeColors().accentColor,
            child: Text(
              "add",
              style: TextStyles.h2Bold.copyWith(color: getSelectedThemeColors().textOnAccentColor),
            ),
            onTap: () {
              bloc.add(CategoryCreateOrUpdateResultEvent(categoryItem));
            },
          ),
        );
      },
      listener: (context, state) {
        if (state.pageStatus == PageStatus.success) {
          Navigator.of(context).maybePop(state.item!);
        }
      },
    );
  }
}
