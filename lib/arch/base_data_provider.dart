import 'package:flutter/material.dart';

import 'base_model.dart';

class BaseDataProvider<T extends BaseModel> {
  T _model;

  BaseDataProvider(this._model);
}
