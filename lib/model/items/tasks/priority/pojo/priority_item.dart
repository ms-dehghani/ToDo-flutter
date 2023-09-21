import 'package:flutter/material.dart';
import 'package:kardone/utils/color_extentions.dart';

import 'priority_static.dart';

class PriorityItem {
  String _id;

  String _title;

  String _description;

  String _color;

  PriorityItem(this._id, this._title, this._color, {String description = ""})
      : _description = description;

  PriorityItem.empty()
      : _id = "",
        _title = "",
        _description = "",
        _color = "#00000000";

  Map<String, Object?> toMap() {
    return {
      filedId: _id,
      filedTitle: _title,
      filedDescription: _description,
      filedColor: _color,
    };
  }

  PriorityItem.fromMap(Map data)
      : _id = data[filedId],
        _title = data[filedTitle],
        _description = data[filedDescription],
        _color = data[filedColor];

  PriorityItem copyWith({String? id, String? title, String? color, String? description}) {
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

  Color get color => HexColor.fromHex(_color);

  set color(Color value) {
    _color = value.toHex();
  }
}
