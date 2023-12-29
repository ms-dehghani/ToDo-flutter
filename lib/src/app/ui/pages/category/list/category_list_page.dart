import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/res/texts.dart';
import 'package:ToDo/src/app/di/di.dart';
import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/logic/category/get/bloc/category_get_bloc.dart';
import 'package:ToDo/src/app/logic/category/get/bloc/category_get_event.dart';
import 'package:ToDo/src/app/logic/category/get/bloc/category_get_page_data.dart';
import 'package:ToDo/src/app/ui/widgets/base/widget_view_template.dart';
import 'package:ToDo/src/app/ui/widgets/bottomsheet/bottomsheet_title_item.dart';
import 'package:ToDo/src/app/ui/widgets/bottomsheet/round_bottom_sheet.dart';
import 'package:ToDo/src/app/ui/widgets/buttons/border_button.dart';
import 'package:ToDo/src/app/ui/widgets/image/image_view.dart';
import 'package:ToDo/src/app/ui/widgets/items/list/category_list_row_item.dart';
import 'package:ToDo/src/app/ui/widgets/progress/in_page_progress.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/utils/device.dart';
import 'package:ToDo/src/utils/extensions/translates_string_extensions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create/create_category_item_page.dart';

class CategoryListPage extends StatelessWidget with WidgetViewTemplate {
  final CategoryGetBloc _categoryGetBloc =
      CategoryGetBloc(categoryUseCase: DI.instance().getCategoryUseCase());

  CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    _categoryGetBloc.add(GetAllCategoryEvent());
    return BlocProvider<CategoryGetBloc>(
      create: (BuildContext context) => _categoryGetBloc,
      child: showPage(context),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return Container(
      color: getSelectedThemeColors(context).onBackground,
      padding: EdgeInsets.only(
          left: Insets.d24, right: Insets.d24, bottom: Insets.pagePadding),
      child: Column(
        children: [
          Expanded(child: _categoryList(context)),
          BorderButton(
            size: Size(getWidth(context), Insets.buttonHeight),
            borderColor: getSelectedThemeColors(context).accentColor,
            backColor: getSelectedThemeColors(context).onBackground,
            rippleColor: getSelectedThemeColors(context).accentColor,
            onTap: () {
              showRoundBottomSheet(
                      context,
                      titleView: BottomSheetTitleItem(
                          color: getSelectedThemeColors(context).accentColor,
                          title: Texts.categoryAddPageTitle.translate,
                          iconSrc: AppIcons.addCategory),
                      SizedBox(
                          height: Insets.addCategoryBottomSheetHeight,
                          child: CreateCategoryItemPage(categoryItem: CategoryItem.empty())))
                  .then((value) {
                if (value != null && value is CategoryItem) {
                  _categoryGetBloc.add(GetAllCategoryEvent());
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  src: AppIcons.addCategory,
                  size: Insets.iconSizeL,
                  color: getSelectedThemeColors(context).accentColor,
                ),
                ItemSplitter.thinSplitter,
                Text(
                  Texts.categoryListPageButtonAdd.translate,
                  style: TextStyles.h3Bold
                      .copyWith(color: getSelectedThemeColors(context).accentColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryList(BuildContext context) {
    return BlocBuilder<CategoryGetBloc, CategoryGetBlocPageData>(
      buildWhen: (previous, current) {
        return true;
      },
      bloc: _categoryGetBloc,
      builder: (context, state) {
        return Container(
            color: getSelectedThemeColors(context).onBackground,
            child: state.pageStatus == PageStatus.success
                ? _categoryListDetail(context, state.categoryList)
                : _loadingWidget());
      },
    );
  }

  Widget _loadingWidget() {
    return Center(child: InPageProgress());
  }

  Widget _categoryListDetail(BuildContext context, List<CategoryItem> categoryList) {
    return Column(
      children: [
        SizedBox(
            width: getWidth(context),
            child: Text(
              Texts.categoryListPageDescription.translate,
              style: TextStyles.h2.copyWith(color: getSelectedThemeColors(context).primaryText),
            )),
        ItemSplitter.ultraThinSplitter,
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: categoryList.map((e) {
              return CategoryListRowItem(
                categoryItem: e,
                onTap: () {
                  Navigator.of(context).maybePop(e);
                },
                onEditTap: () {
                  showRoundBottomSheet(
                      context,
                      titleView: BottomSheetTitleItem(
                          color: getSelectedThemeColors(context).accentColor,
                          title: Texts.categoryEditPageTitle.translate,
                          iconSrc: AppIcons.addCategory),
                      SizedBox(
                          height: getHeight(context) / 2.5,
                          child: CreateCategoryItemPage(
                            categoryItem: e,
                          ))).then((value) {
                    if (value != null && value is CategoryItem) {
                      _categoryGetBloc.add(GetAllCategoryEvent());
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
