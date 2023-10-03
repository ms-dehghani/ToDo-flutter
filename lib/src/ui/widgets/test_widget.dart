import 'package:flutter/material.dart';
import 'package:kardone/src/ui/widgets/base/widget_view_template.dart';

class TestWidget extends StatelessWidget with WidgetViewTemplate {

  @override
  Widget build(BuildContext context) {
    return phoneView();
  }

  @override
  Widget phoneView() {
    return Container();
  }

}
