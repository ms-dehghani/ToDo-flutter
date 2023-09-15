import 'package:flutter/material.dart';

import 'base_model.dart';

class BasePresenter<T extends BaseModel> {
  T _model;

  BasePresenter(this._model);
}
