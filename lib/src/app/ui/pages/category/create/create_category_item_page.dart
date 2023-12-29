import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/res/texts.dart';
import 'package:ToDo/src/app/di/di.dart';
import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/category/create_update/bloc/category_create_update_bloc.dart';
import 'package:ToDo/src/app/logic/category/create_update/bloc/category_create_update_event.dart';
import 'package:ToDo/src/app/logic/category/create_update/bloc/category_create_update_page_data.dart';
import 'package:ToDo/src/app/ui/widgets/base/widget_view_template.dart';
import 'package:ToDo/src/app/ui/widgets/buttons/custom_raised_button.dart';
import 'package:ToDo/src/app/ui/widgets/items/form/form_item.dart';
import 'package:ToDo/src/app/ui/widgets/items/form/text_filed_item.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCategoryItemPage extends StatelessWidget with WidgetViewTemplate {
  late final CategoryCreateOrUpdateBloc bloc;

  CategoryItem categoryItem;

  CreateCategoryItemPage({super.key, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCreateOrUpdateBloc>(
      create: (BuildContext context) => bloc = CategoryCreateOrUpdateBloc(
          categoryUseCase: DI.instance().getCategoryUseCase(), categoryItem: categoryItem),
      child: Material(
        color: getSelectedThemeColors(context).onBackground,
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
          ItemSplitter.ultraThinSplitter,
          _titleWidget(),
          ItemSplitter.ultraThinSplitter,
          _createButton()
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return FormItem(
        title: Texts.categoryAddPageRowTitle.translate,
        child: TextFiledItem(
          hint: Texts.categoryAddPageRowTitleHint.translate,
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
                ? getSelectedThemeColors(context).accentLiteColor
                : getSelectedThemeColors(context).accentColor,
            rippleColor: getSelectedThemeColors(context).accentColor,
            child: Text(
              categoryItem.ID.isEmpty
                  ? Texts.categoryAddPageButtonAdd.translate
                  : Texts.categoryEditPageButtonEdit.translate,
              style: TextStyles.h2Bold
                  .copyWith(color: getSelectedThemeColors(context).textOnAccentColor),
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
