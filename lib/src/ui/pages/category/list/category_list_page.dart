import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/res/texts.dart';
import 'package:kardone/src/di/di.dart';
import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/category/get/bloc/category_get_bloc.dart';
import 'package:kardone/src/logic/category/get/bloc/category_get_event.dart';
import 'package:kardone/src/logic/category/get/bloc/category_get_page_data.dart';
import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';
import 'package:kardone/src/ui/widgets/base/widget_view_template.dart';
import 'package:kardone/src/ui/widgets/bottomsheet/round_bottom_sheet.dart';
import 'package:kardone/src/ui/widgets/buttons/border_button.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/ui/widgets/items/list/category_list_row_item.dart';
import 'package:kardone/src/ui/widgets/bottomsheet/bottomsheet_title_item.dart';
import 'package:kardone/src/ui/widgets/progress/in_page_progress.dart';
import 'package:kardone/src/utils/device.dart';
import 'package:kardone/src/utils/extentions/translates_string_extentions.dart';
import 'package:kardone/src/utils/theme_utils.dart';

import '../create/create_category_item_page.dart';

class CategoryListPage extends StatelessWidget with WidgetViewTemplate {
  late CategoryGetBloc _categoryGetBloc;

  CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryGetBloc>(
          create: (BuildContext context) {
            return _categoryGetBloc =
                CategoryGetBloc(categoryRepository: DI.instance().getCategoryRepository())
                  ..add(GetAllCategoryEvent());
          },
        ),
      ],
      child: showPage(context),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return Container(
      color: getSelectedThemeColors().onBackground,
      padding: EdgeInsets.only(left: Insets.pagePadding, right: Insets.pagePadding, bottom: Insets.pagePadding),
      child: Column(
        children: [
          Expanded(child: _categoryList(context)),
          BorderButton(
            size: Size(getWidth(context), Insets.buttonHeight),
            borderColor: getSelectedThemeColors().accentColor,
            backColor: getSelectedThemeColors().onBackground,
            rippleColor: getSelectedThemeColors().accentColor,
            onTap: () {
              showRoundBottomSheet(
                      context,
                      titleView: BottomSheetTitleItem(
                          color: getSelectedThemeColors().accentColor,
                          title: Texts.categoryAddPageTitle.translate,
                          iconSrc: AppIcons.addCategory),
                      SizedBox(
                          height: getHeight(context) / 2.5,
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
                  color: getSelectedThemeColors().accentColor,
                ),
                ItemSplitter.thinSplitter,
                Text(
                  Texts.categoryListPageButtonAdd.translate,
                  style: TextStyles.h3Bold.copyWith(color: getSelectedThemeColors().accentColor),
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
      builder: (context, state) {
        return Container(
            color: getSelectedThemeColors().onBackground,
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
              style: TextStyles.h2,
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
                          color: getSelectedThemeColors().accentColor,
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
