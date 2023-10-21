import 'package:equatable/equatable.dart';

import '../../category/pojo/category_item.dart';
import '../../priority/pojo/priority_item.dart';
import 'task_static.dart';

class TaskItem extends Equatable {
  String _taskId;
  String _title;
  String _description;
  int _taskTimestamp;
  CategoryItem? _categoryItem;
  PriorityItem? _priorityItem;
  bool _isDone;

  TaskItem(
      {required String id,
      required String title,
      required String description,
      CategoryItem? categoryItem,
      PriorityItem? priorityItem,
      bool isDone = false,
      int taskTimestamp = 0})
      : _title = title,
        _taskId = id,
        _description = description,
        _categoryItem = categoryItem,
        _isDone = isDone,
        _priorityItem = priorityItem,
        _taskTimestamp = taskTimestamp;

  TaskItem.empty({int? timestamp})
      : _taskId = "",
        _title = "",
        _description = "",
        _taskTimestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch,
        _isDone = false,
        _priorityItem = null,
        _categoryItem = null;

  Map<String, Object?> toMap() {
    return {
      filedId: _taskId,
      filedTitle: _title,
      filedDescription: _description,
      filedTimestamp: _taskTimestamp,
      filedCategoryID: _categoryItem?.ID ?? "",
      filedPriorityID: _priorityItem?.ID ?? "",
      filedDone: _isDone ? 1 : 0,
    };
  }

  TaskItem.fromMap(Map data)
      : _taskId = data[filedId] ?? "",
        _title = data[filedTitle] ?? "",
        _description = data[filedDescription] ?? "",
        _taskTimestamp = data[filedTimestamp] ?? "",
        _isDone = (data[filedDone] ?? 1) == 1 ? true : false;

  TaskItem copyWith(
      {String? taskId,
      String? title,
      String? description,
      CategoryItem? categoryItem,
      PriorityItem? priorityItem,
      bool? isDone,
      int? taskTimestamp}) {
    return TaskItem(
        id: taskId ?? _taskId,
        title: title ?? _title,
        description: description ?? _description,
        categoryItem: categoryItem ?? _categoryItem,
        priorityItem: priorityItem ?? _priorityItem,
        isDone: isDone ?? _isDone,
        taskTimestamp: taskTimestamp ?? _taskTimestamp);
  }

  TaskItem clone() {
    return copyWith();
  }

  String get ID => _taskId;

  set ID(String value) {
    _taskId = value;
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

  bool get isDone => _isDone;

  set isDone(bool value) {
    _isDone = value;
  }

  int get taskTimestamp => _taskTimestamp;

  set taskTimestamp(int value) {
    _taskTimestamp = value;
  }

  @override
  List<Object?> get props => [
        _taskId,
        _taskTimestamp,
        _taskTimestamp,
        _description,
        _categoryItem,
        _priorityItem,
        _isDone
      ];
}
