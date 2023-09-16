
import 'package:kardone/model/items/category/pojo/category_item.dart';
import 'package:kardone/model/items/priority/pojo/priority_item.dart';

class TaskItem {
  String _title, _description;
  int _taskTimestamp;
  CategoryItem? _categoryItem;
  PriorityItem? _priorityItem;

  TaskItem(
      {required String title,
      required String description,
      CategoryItem? categoryItem,
      PriorityItem? priorityItem,
      int taskTimestamp = 0})
      : _title = title,
        _description = description,
        _categoryItem = categoryItem,
        _priorityItem = priorityItem,
        _taskTimestamp = taskTimestamp;

  TaskItem.empty()
      : _title = "",
        _description = "",
        _taskTimestamp = 0,
        _priorityItem = null,
        _categoryItem = null;

  TaskItem copyWith(
      {String? title,
      String? description,
      CategoryItem? categoryItem,
      PriorityItem? priorityItem,
      int? taskTimestamp}) {
    return TaskItem(
        title: title ?? _title,
        description: description ?? _description,
        categoryItem: categoryItem ?? _categoryItem,
        priorityItem: priorityItem ?? _priorityItem,
        taskTimestamp: taskTimestamp ?? _taskTimestamp);
  }

  TaskItem clone() {
    return copyWith();
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  CategoryItem? get categoryItem => _categoryItem;

  set categoryItem(CategoryItem? value) {
    _categoryItem = value;
  }

  PriorityItem? get priorityItem => _priorityItem;

  set priorityItem(PriorityItem? value) {
    _priorityItem = value;
  }

  int get taskTimestamp => _taskTimestamp;

  set taskTimestamp(int value) {
    _taskTimestamp = value;
  }
}
