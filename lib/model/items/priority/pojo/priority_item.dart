import 'package:flutter/material.dart';

class PriorityItem {
  String _id;

  String _title;

  String _description;

  Color _color;

  PriorityItem(this._id, this._title, this._color, {String description = ""})
      : _description = description;

  PriorityItem.empty()
      : _id = "",
        _title = "",
        _description = "",
        _color = Colors.transparent;

  PriorityItem copyWith({String? id, String? title, Color? color, String? description}) {
    return PriorityItem(id ?? _id, title ?? _title, color ?? _color,
        description: description ?? _description);
  }

  PriorityItem clone() {
    return copyWith();
  }

  String get ID => _id;

  set ID(String value) {
    _id = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  Color get color => _color;

  set color(Color value) {
    _color = value;
  }
}
