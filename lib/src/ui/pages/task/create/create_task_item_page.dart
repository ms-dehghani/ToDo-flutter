import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kardone/res/dimens.dart';
import 'package:kardone/res/drawable.dart';
import 'package:kardone/res/text_style.dart';
import 'package:kardone/src/di/di.dart';
import 'package:kardone/src/logic/base/page_status.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_bloc.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_event.dart';
import 'package:kardone/src/logic/task/create_update/bloc/task_create_update_page_data.dart';
import 'package:kardone/src/model/items/tasks/task/pojo/task_item.dart';
import 'package:kardone/src/ui/widgets/app_bar.dart';
import 'package:kardone/src/ui/widgets/base/widget_view_template.dart';
import 'package:kardone/src/ui/widgets/buttons/CustomButton.dart';
import 'package:kardone/src/ui/widgets/buttons/back_button.dart';
import 'package:kardone/src/ui/widgets/image/image_view.dart';
import 'package:kardone/src/ui/widgets/items/form/button_filed_item.dart';
import 'package:kardone/src/ui/widgets/items/form/form_item.dart';
import 'package:kardone/src/ui/widgets/items/form/priority_selector_filed_item.dart';
import 'package:kardone/src/ui/widgets/items/form/text_filed_item.dart';
import 'package:kardone/src/utils/theme_utils.dart';

class CreateTaskItemPage extends StatefulWidget {
  TaskItem taskItem;

  CreateTaskItemPage({required this.taskItem});

  @override
  State<StatefulWidget> createState() {
    return _CreateTaskItemPageState();
  }
}

class _CreateTaskItemPageState extends State<CreateTaskItemPage> with WidgetViewTemplate {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCreateOrUpdateBloc>(
          create: (BuildContext context) =>
              TaskCreateOrUpdateBloc(taskRepository: DI.instance().getTaskRepository()),
        ),
      ],
      child: Material(
        color: getSelectedThemeColors().itemFillColor,
        child: SafeArea(child: showPage(context)),
      ),
    );
  }

  @override
  Widget phoneView() {
    return Column(
      children: [
        ApplicationAppBar(
            color: getSelectedThemeColors().pageBackground,
            leftWidget: AppBarBackButton(
              onTap: () => Navigator.of(context).maybePop(),
            ),
            centerWidget: Text(
              "add page",
              style: TextStyles.h2Bold.copyWith(color: getSelectedThemeColors().primaryColor),
            )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(Insets.med),
            child: Column(
              children: [Expanded(child: _taskRows()), _createButton()],
            ),
          ),
        )
      ],
    );
  }

  Widget _taskRows() {
    return ListView(children: [
      ItemSplitter.thickSplitter,
      _titleWidget(),
      ItemSplitter.thickSplitter,
      _categoryWidget(),
      ItemSplitter.thickSplitter,
      PrioritySelectorFiledItem(
        priorityList: DI.instance().prioritiesItem,
        selectedItem: widget.taskItem.priorityItem,
        onPriorityChange: (item) {
          widget.taskItem.priorityItem = item;
        },
      ),
      ItemSplitter.thickSplitter,
      _descriptionWidget(),
      ItemSplitter.thickSplitter,
      // PrioritySelectorFiledItem(
      //   priorityList: DI.instance().getPriorityRepository().getPriorities(),
      //   selectedItem: widget.taskItem.priorityItem,
      //   onPriorityChange: (selectedItem) {
      //     setState(() {
      //       widget.taskItem.priorityItem = selectedItem;
      //     });
      //   },
      // )
    ]);
  }

  Widget _titleWidget() {
    return FormItem(
        title: "title",
        child: TextFiledItem(
          hint: 'text',
          text: widget.taskItem.title,
          onValueChange: (title) {
            widget.taskItem.title = title;
          },
        ));
  }

  Widget _descriptionWidget() {
    return FormItem(
        title: "desc",
        child: TextFiledItem(
          minLines: 5,
          maxLines: 25,
          hint: 'desc',
          text: widget.taskItem.description,
          icon: ImageView(
            src: "desc",
            size: Insets.iconSizeS,
          ),
          iconColor: getSelectedThemeColors().primaryText,
          onValueChange: (desc) {
            widget.taskItem.description = desc;
          },
        ));
  }

  Widget _categoryWidget() {
    return FormItem(
        title: "category",
        child: ButtonFiledItem(
          icon: ImageView(
            src: "",
            size: Insets.iconSizeS,
          ),
          child: Text(
            widget.taskItem.categoryItem?.title ?? "add category",
            style: TextStyles.h3.copyWith(color: getSelectedThemeColors().secondaryText),
          ),
        ));
  }

  Widget _createButton() {
    return BlocConsumer<TaskCreateOrUpdateBloc, TaskCreateUpdateBlocPageData>(
      listener: (context, state) {
        if (state.pageStatus == PageStatus.success) {
          Navigator.of(context).maybePop();
        } else {}
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: CustomButton(
            size: Size(double.infinity, Insets.buttonHeight),
            fillColor: getSelectedThemeColors().primaryColor,
            child: Text(
              "add",
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
