import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ToDo/res/dimens.dart';
import 'package:ToDo/res/drawable.dart';
import 'package:ToDo/res/text_style.dart';
import 'package:ToDo/res/texts.dart';
import 'package:ToDo/src/app/logic/base/page_status.dart';
import 'package:ToDo/src/app/ui/widgets/app_bar.dart';
import 'package:ToDo/src/app/ui/widgets/buttons/custom_raised_button.dart';
import 'package:ToDo/src/app/ui/widgets/image/image_view.dart';
import 'package:ToDo/src/app/di/di.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_bloc.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_event.dart';
import 'package:ToDo/src/app/logic/task/create_update/bloc/task_create_update_page_data.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';
import 'package:ToDo/src/app/ui/pages/category/list/category_list_page.dart';
import 'package:ToDo/src/app/ui/widgets/base/widget_view_template.dart';
import 'package:ToDo/src/app/ui/widgets/bottomsheet/round_bottom_sheet.dart';
import 'package:ToDo/src/app/ui/widgets/buttons/back_button.dart';
import 'package:ToDo/src/app/ui/widgets/items/form/button_filed_item.dart';
import 'package:ToDo/src/app/ui/widgets/items/form/form_item.dart';
import 'package:ToDo/src/app/ui/widgets/items/form/priority_selector_filed_item.dart';
import 'package:ToDo/src/app/ui/widgets/items/form/text_filed_item.dart';
import 'package:ToDo/src/app/ui/widgets/bottomsheet/bottomsheet_title_item.dart';
import 'package:ToDo/src/utils/device.dart';
import 'package:ToDo/src/utils/extentions/translates_string_extentions.dart';
import 'package:ToDo/src/utils/theme_utils.dart';
import 'package:ToDo/src/utils/time_util.dart';

class CreateTaskItemPage extends StatefulWidget {
  TaskItem taskItem;

  CreateTaskItemPage({super.key, required this.taskItem});

  @override
  State<CreateTaskItemPage> createState() => _CreateTaskItemPageState();
}

class _CreateTaskItemPageState extends State<CreateTaskItemPage> with WidgetViewTemplate {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCreateOrUpdateBloc>(
          create: (BuildContext context) =>
              TaskCreateOrUpdateBloc(taskUseCase: DI.instance().getTaskUseCase()),
        ),
      ],
      child: Material(
        color: getSelectedThemeColors().itemFillColor,
        child: Scaffold(body: SafeArea(child: showPage(context))),
      ),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return Column(
      children: [
        ApplicationAppBar(
            color: getSelectedThemeColors().pageBackground,
            leftWidget: AppBarBackButton(
              onTap: () => Navigator.of(context).maybePop(),
            ),
            centerWidget: Text(
              Texts.addTaskPageTitle.translate,
              style: TextStyles.h2Bold.copyWith(color: getSelectedThemeColors().primaryColor),
            )),
        Expanded(
          child: Column(
            children: [Expanded(child: _taskRows(context)), _createButton()],
          ),
        )
      ],
    );
  }

  Widget _taskRows(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(
          left: Insets.pagePadding,
          right: Insets.pagePadding,
          top: Insets.pagePadding,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        children: [
          ItemSplitter.thickSplitter,
          _titleWidget(),
          ItemSplitter.thickSplitter,
          _categoryWidget(context),
          ItemSplitter.thickSplitter,
          ItemSplitter.ultraThinSplitter,
          _priorityWidget(),
          ItemSplitter.thickSplitter,
          _dateWidget(),
          ItemSplitter.thickSplitter,
          _descriptionWidget(),
          ItemSplitter.thickSplitter,
        ]);
  }

  Widget _titleWidget() {
    return FormItem(
        title: Texts.addTaskRowTitle.translate,
        child: TextFiledItem(
          hint: Texts.addTaskRowTitleHint.translate,
          text: widget.taskItem.title,
          onValueChange: (title) {
            widget.taskItem.title = title;
          },
        ));
  }

  Widget _priorityWidget() {
    return FormItem(
      title: Texts.addTaskRowPriority.translate,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Insets.med),
        child: PrioritySelectorFiledItem(
          priorityList: DI.instance().prioritiesItem,
          selectedItem: widget.taskItem.priorityItem,
          onPriorityChange: (item) {
            widget.taskItem.priorityItem = item;
          },
        ),
      ),
    );
  }

  Widget _dateWidget() {
    Color color = getSelectedThemeColors().primaryText;
    return FormItem(
      title: Texts.addTaskRowDate.translate,
      child: ButtonFiledItem(
        icon: ImageView(
          src: AppIcons.calendar,
          size: Insets.iconSizeS,
          color: color,
        ),
        child: Text(timeToText(widget.taskItem.taskTimestamp),
            style: TextStyles.h3.copyWith(
              color: color,
            )),
        onTap: () {
          showDatePickerDialog(context, initialTime: widget.taskItem.taskTimestamp,
              onDateSelected: (timestamp) {
            setState(() {
              widget.taskItem.taskTimestamp = timestamp;
            });
          });
        },
      ),
    );
  }

  Widget _descriptionWidget() {
    return FormItem(
        title: Texts.addTaskRowDescription.translate,
        child: TextFiledItem(
          minLines: 5,
          maxLines: 25,
          hint: Texts.addTaskRowDescriptionHint.translate,
          text: widget.taskItem.description,
          icon: AppIcons.descriptionOutline,
          iconColor: getSelectedThemeColors().primaryText,
          onValueChange: (desc) {
            widget.taskItem.description = desc;
          },
        ));
  }

  Widget _categoryWidget(BuildContext context) {
    Color color = (widget.taskItem.categoryItem?.title ?? "").isNotEmpty
        ? getSelectedThemeColors().primaryText
        : getSelectedThemeColors().secondaryText;
    return FormItem(
        title: Texts.addTaskRowCategory.translate,
        child: ButtonFiledItem(
          icon: ImageView(
            src: AppIcons.categoryOutline,
            size: Insets.iconSizeS,
            color: color,
          ),
          child: Text(widget.taskItem.categoryItem?.title ?? Texts.addTaskRowCategoryHint.translate,
              style: TextStyles.h3.copyWith(
                color: color,
              )),
          onTap: () {
            showRoundBottomSheet(
                    context,
                    titleView: BottomSheetTitleItem(
                        color: getSelectedThemeColors().iconGreen,
                        title: Texts.categoryListPageTitle.translate,
                        iconSrc: AppIcons.categoryOutline),
                    SizedBox(
                        height: getHeight(context) / 2 > 500 ? getHeight(context) / 2 : 500,
                        child: CategoryListPage()))
                .then((value) {
              if (value != null && value is CategoryItem) {
                setState(() {
                  widget.taskItem.categoryItem = value;
                });
              }
            });
          },
        ));
  }

  Widget _createButton() {
    return BlocConsumer<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      listener: (context, state) {
        if (state.pageStatus == PageStatus.success) {
          Navigator.of(context).maybePop();
        } else if (state.pageStatus == PageStatus.failure){
          String detail = "";

          if (widget.taskItem.title.isEmpty) {
            detail += "${Texts.taskSelectTitleError.translate}\n";
          }
          if (widget.taskItem.priorityItem == null) {
            detail += "${Texts.taskSelectPriorityError.translate}\n";
          }
          if (widget.taskItem.categoryItem == null) {
            detail += "${Texts.taskSelectCategoryError.translate}\n";
          }
          var snackBar = SnackBar(
              content: Text(
            detail,
            style: TextStyles.h3.copyWith(color: Colors.white),
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(Insets.pagePadding),
          child: CustomRaisedButton(
            size: Size(double.infinity, Insets.buttonHeight),
            fillColor: getSelectedThemeColors().primaryColor,
            child: Text(
              Texts.addTaskButtonAdd.translate,
              style: TextStyles.h2Bold.copyWith(color: getSelectedThemeColors().textOnAccentColor),
            ),
            onTap: () {
              context.read<TaskCreateOrUpdateBloc>().add(TaskCreateOrUpdateEvent(widget.taskItem));
            },
          ),
        );
      },
    );
  }
}
