import 'package:equatable/equatable.dart';

import 'category_static.dart';

class CategoryItem extends Equatable{
  String _id;

  String _title;

  String _description;

  String _parentId;

  CategoryItem(this._id, this._title, {String parentID = "", String description = ""})
      : _parentId = parentID,
        _description = description;

  CategoryItem.empty()
      : _id = "",
        _title = "",
        _description = "",
        _parentId = "";

  Map<String, Object?> toMap() {
    return {
      filedId: _id,
      filedTitle: _title,
      filedDescription: _description,
      filedParentID: _parentId,
    };
  }

  CategoryItem.fromMap(Map data)
      : _id = data[filedId] ?? "",
        _title = data[filedTitle] ?? "",
        _description = data[filedDescription] ?? "",
        _parentId = data[filedParentID] ?? "";

  CategoryItem copyWith({String? id, String? title, String? parentId, String? description}) {
    return CategoryItem(id ?? _id, title ?? _title,
        parentID: parentId ?? _parentId, description: description ?? _description);
  }

  CategoryItem clone() {
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

  String get parentID => _parentId;

  set parentID(String value) {
    _parentId = value;
  }

  @override
  List<Object?> get props => [_id,_title,_description,_parentId];
}
