import 'package:flutter/material.dart';
import 'package:kardone/src/app/ui/widgets/base/widget_view_template.dart';

class TestWidget extends StatelessWidget with WidgetViewTemplate {

  @override
  Widget build(BuildContext context) {
    return phoneView(context);
  }

  @override
  Widget phoneView(BuildContext context) {
    return Container();
  }

}
